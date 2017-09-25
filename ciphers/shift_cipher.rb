# frozen_string_literal: true

class ShiftCipher
  def self.encrypt(**params)
    new(**params).encrypt
  end

  def self.decrypt(**params)
    new(**params).decrypt
  end

  def initialize(str:, shift: 13)
    @text = str.split(//)
    @ascii = text.map { |t| t.ord - 'a'.ord }
    @shift = shift
  end

  def encrypt
    ascii.each { |a| print (((a + shift) % 26) + 'a'.ord).chr }
    print "\n"
  end

  def decrypt
    ascii.each { |a| print (((a - shift) % 26) + 'a'.ord).chr }
    print "\n"
  end

  private

  attr_reader :text, :ascii, :shift
end
