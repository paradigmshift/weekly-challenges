class Translation

  def self.to_codons(rna, codons=[]) # could be slow for large strands since Ruby does not have TCO
    rna.length == 0 ? codons : (to_codons(rna[3, rna.length], codons.push(rna[0,3])))
  end

  def self.of_codon(codon)
    CODON_PROTEIN[codon.to_sym]
  end

  def self.of_rna(strand)
    proteins = to_codons(strand).map do |codon|
      of_codon(codon.to_sym)
    end.take_while { |protein| protein != "STOP" }

    proteins.member?(nil) ? (raise InvalidCodonError) : proteins
  end

  CODON_PROTEIN = {
    AUG: "Methionine",
    UUU: "Phenylalanine",
    UUC: "Phenylalanine",
    UUA: "Leucine",
    UUG: "Leucine",
    UCU: "Serine",
    UCC: "Serine",
    UCA: "Serine",
    UCG: "Serine",
    UAU: "Tyrosine",
    UAC: "Tyrosine",
    UGU: "Cysteine",
    UGC: "Cysteine",
    UGG: "Tryptophan",
    UAA: "STOP",
    UAG: "STOP",
    UGA: "STOP"}

end

class InvalidCodonError < StandardError
end
