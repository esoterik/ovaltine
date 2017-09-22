# frozen_string_literal: true

require 'spec_helper'
require 'frequency_analysis'

RSpec.describe FrequencyAnalysis do
  describe '#to_s' do
    # generate a test string that has occurrences of each letter corresponding
    # to when it occurs in the alphabet (e.g. 1 'a', 3 'c's, etc)
    let!(:test_string) do
      [].tap do |str|
        ('a'..'z').to_a.each_with_index { |c, i| str << [c] * (i + 1) }
      end.shuffle.join('').freeze
    end

    context 'default' do
      it 'prints counts sorted from most frequent to least' do
        expected = [].tap do |exp|
          ('a'..'z').to_a.each_with_index { |c, i| exp << "#{c}: #{(i + 1)}" }
        end.reverse.join("\n")
        freq = described_class.new(ciphertext: test_string)
        expect(freq.to_s).to eq(expected)
      end
    end

    context 'percentage: true' do
      it 'prints frequencies sorted from most frequent to least' do
        expected = [].tap do |exp|
          ('a'..'z').to_a.each_with_index do |c, i|
            exp << "#{c}: #{(i + 1) / test_string.size.to_f}"
          end
        end.reverse.join("\n")
        freq = described_class.new(ciphertext: test_string)
        expect(freq.to_s(percentage: true)).to eq(expected)
      end
    end

    context 'sort: :alpha' do
      it 'prints counts sorted from a to z' do
        expected = [].tap do |exp|
          ('a'..'z').to_a.each_with_index { |c, i| exp << "#{c}: #{(i + 1)}" }
        end.join("\n")
        freq = described_class.new(ciphertext: test_string)
        expect(freq.to_s(sort: :alpha)).to eq(expected)
      end
    end
  end
end
