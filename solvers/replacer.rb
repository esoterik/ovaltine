# frozen_string_literal: true

class Replacer
  attr_reader :ciphertext, :working

  def initialize(ciphertext:)
    @ciphertext = ciphertext.split(//).freeze
    @working = ['_'] * ciphertext.length
    @replacements = {}
    indicies
  end

  def guess(cipher:, plain:)
    return if invalid_plaintext_substitution? plain
    return unless ciphertext.include? cipher
    replacements[cipher] = plain
    indicies[cipher].each { |i| working[i] = plain }
  end

  private

  attr_accessor :replacements
  attr_writer :working

  def invalid_plaintext_substitution?(plain)
    plain.empty? || replacements.values.include?(plain)
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
end
