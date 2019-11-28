# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  subject { described_class.new(category: category, amount: amount) }

  let(:category) { described_class.categories[:buy] }
  let(:amount) { 10  }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :amount }

    context 'when no category present' do
      let(:category) { nil }

      before { subject.validate }

      it 'raises error' do
        expect(subject.errors.messages).to match a_hash_including(
          category: ['is not included in the list']
        )
      end
    end
  end
end
