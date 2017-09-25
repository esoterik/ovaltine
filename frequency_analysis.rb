# Sydney Young

class FrequencyAnalysis 
  attr_reader :solved, :replacements

  def initialize(ciphertext:)
    @ciphertext = ciphertext.split(//)
    @solved = ['_'] * size
    @replacements = Hash.new
    @replacements.default = '_'
    compute
  end

  def print(sort: :freq, freq: false)
    return unless SORTS.include? sort
    mthd = "counts_sorted_by_#{sort}".to_sym
    send(mthd).each do |f|
      val = freq ? f[1] / size.to_f : f[1]
      puts "#{f[0]}: #{val}" 
    end
  end

  def replace(cipher:, plain:)
    return if plain.empty? 
    return if replacements.values.include? plain
    return unless ciphertext.include? cipher
    replacements[cipher] = plain
    indicies[cipher].each { |i| solved[i] = plain }
  end

  def display_solved
    puts solved.join('')
  end

  private

  SORTS = %i(alpha freq)

  attr_reader :ciphertext, :unique_letters, :freq_counts, :size,
    :indicies

  attr_writer :solved, :replacements

  def compute
    freq_counts
    indicies
  end

  def counts_sorted_by_freq
    freq_counts.sort { |a, b| b[1] <=> a[1] }
  end

  def counts_sorted_by_alpha
    freq_counts.sort { |a, b| a[0] <=> b[0] }
  end

  def freq_counts
    @freq_counts ||= unique_letters.map do |u|
                       count = ciphertext.count { |c| c == u }
                       puts "#{u}: #{count / size.to_f}"
                       [u, count]
                     end
  end

  def indicies
    @indicies ||= unique_letters.map do |u|
      temp = []
      ciphertext.each_with_index { |c, i| temp << i if c == u }
      [u, temp] 
    end.to_h
  end

  def unique_letters
    @unique_letters ||= ciphertext.uniq.sort
  end
  
  def size
    @size ||= ciphertext.size
  end
end
