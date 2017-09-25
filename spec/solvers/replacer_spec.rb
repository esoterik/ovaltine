# frozen_string_literal: true

require 'spec_helper'
require 'replacer'

RSpec.describe Replacer do
  describe '#guess' do
    it 'replaces underscores in working with the guessed letter' do
      test_str = 'abcdea'
      replacer = described_class.new(ciphertext: test_str)
      expect { replacer.guess(cipher: 'b', plain: 'c') }.to \
        change { replacer.working[1] }.from('_').to('c')
    end
    it 'does nothing when plain is blank' do
      test_str = 'abcdea'
      replacer = described_class.new(ciphertext: test_str)
      expect { replacer.guess(cipher: 'b', plain: '') }.not_to \
        change { replacer.working[1] }
    end
    it 'does not modify original ciphertext' do
      test_str = 'abcdea'
      replacer = described_class.new(ciphertext: test_str)
      expect { replacer.guess(cipher: 'b', plain: 'c') }.not_to \
        change { replacer.ciphertext }
    end
    it 'does nothing when the plain letter has already been guessed' do
      test_str = 'abcdea'
      replacer = described_class.new(ciphertext: test_str)
      replacer.guess(cipher: 'a', plain: 'c')
      expect { replacer.guess(cipher: 'b', plain: 'c') }.not_to \
        change { replacer.working[1] }
    end
  end
end
