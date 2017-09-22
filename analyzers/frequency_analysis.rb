# frozen_string_literal: true

class FrequencyAnalysis
  def initialize(ciphertext:)
    @ciphertext = ciphertext.split(//)
    freq_counts
  end

  def to_s(sort: :freq, percentage: false)
    sorted = sort_counts(sort)
    [].tap do |str|
      sorted.each { |freq| str << format(freq, percentage: percentage) }
    end.join("\n")
  end

  private

  # define index mapping for freq_counts array
  INDEX = { alpha: 0, freq: 1 }.freeze

  attr_reader :ciphertext, :unique_letters, :freq_counts, :size

  def format(freq, percentage: false)
    val = percentage ? freq[1] / size.to_f : freq[1]
    "#{freq[0]}: #{val}"
  end

  def sort_counts(index_key)
    return freq_counts unless INDEX.keys.include? index_key
    freq_counts.sort { |a, b| send("#{index_key}_compare", a, b) }
  end

  def freq_compare(a, b)
    b[INDEX[:freq]] <=> a[INDEX[:freq]]
  end

  def alpha_compare(a, b)
    a[INDEX[:alpha]] <=> b[INDEX[:alpha]]
  end

  def freq_counts
    # freq_counts is an array to allow for sorting
    # each entry is [character, count] e.g. ['a', 20]
    @freq_counts ||= unique_letters.map do |u|
      count = ciphertext.count { |c| c == u }
      [u, count]
    end
  end

  def unique_letters
    @unique_letters ||= ciphertext.uniq.sort
  end

  def size
    @size ||= ciphertext.size
  end
end
