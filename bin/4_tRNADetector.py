# This script finds anticodons flanked by palindrome sequences.
# To use it you have to modify the "motivo" variable and run twice with the anticodon and then with the codon
# This is in case the tRNA is in the complementary chain.
# The result is the printing on the screen of a fasta file with candidate sequences to be tRNAs.

motivo = 'GGT'
archivo_fasta = '/home/hemiptero/python/Atexcac.fasta'

from Bio import SeqIO
import re


def reverse_complement(secuencia):
    """
    Calcula la reversa complementaria de una secuencia de ADN.

    Args:
        secuencia: La secuencia de ADN a procesar.

    Returns:
        La reversa complementaria de la secuencia.
    """
    complementarias = {'A': 'T', 'T': 'A', 'C': 'G', 'G': 'C'}
    reversa_complementaria = ''.join(complementarias.get(base, base) for base in secuencia[::-1])  # Reemplazo manual y reverso
    return reversa_complementaria


def es_palindromo_complementario(secuencia):
  """
  Verifica si una secuencia de ADN es palindrómica complementaria.

  Args:
      secuencia: La secuencia de ADN a verificar.

  Returns:
      True si la secuencia es palindrómica complementaria, False en caso contrario.
  """
  secuencia_complementaria = reverse_complement(secuencia)
  return secuencia == secuencia_complementaria



archivo_fasta = '/home/hemiptero/python/Atexcac.fasta'

# Cargamos las secuencias del archivo FASTA
secuencias = list(SeqIO.parse(archivo_fasta, "fasta"))



id = 1
for secuencias in secuencias:
    coincidencias = re.finditer(motivo, str(secuencias.seq))
    if coincidencias:
        for coincidencia in coincidencias:
            inicio = coincidencia.start()
            fin = coincidencia.end()
            subsecuencia = secuencias.seq[inicio - 5:inicio-2] + secuencias.seq[fin+2:fin + 5]
            if es_palindromo_complementario(subsecuencia):
                print('>',id, sep="")
                print(secuencias.seq[inicio-30:fin+30])
                id = id +1
