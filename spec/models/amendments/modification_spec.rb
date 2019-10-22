# frozen_string_literal: true

require 'rails_helper'

describe Modification do
  subject(:modification) { build(:standard_modification, amendment: amendment, amount: amount) }

  let(:amendment) { create(:standard_amendment) }
  let(:amount) { 101 }

  it { is_expected.to be_valid }

  context 'when has no amendment' do
    let(:amendment) { nil }

    it { is_expected.to be_invalid }
  end

  context 'when amendment already has a modification' do
    let(:amendment) { create(:standard_amendment, :with_modifications) }

    it { is_expected.to be_locked_section }
  end

  context 'when abs_amount changes' do
    subject(:modification) { build(:standard_modification, amendment: amendment, abs_amount: abs_amount, amount_sign: amount_sign) }

    let(:abs_amount) { 1.0 }
    let(:amount_sign) { '+' }

    describe '#amount' do
      subject { modification.amount }

      let(:abs_amount) { 1.0 }
      let(:amount_sign) { '-' }

      it { is_expected.to eq(-1.0) }
    end
  end

  context 'when amount is zero' do
    subject(:modification) { build(:standard_modification, amendment: amendment, amount: amount) }

    let(:amount) { 0.0 }

    describe '#amount_sign' do
      subject { modification.amount_sign }

      it { is_expected.to eq('+') }
    end

    describe '#amount_sign_human' do
      subject { modification.amount_sign_human }

      it { is_expected.to eq(:addition) }
    end

    describe '#abs_amount' do
      subject { modification.abs_amount }

      it { is_expected.to eq(0.0) }
    end
  end

  context 'when amount is positive' do
    subject(:modification) { build(:standard_modification, amendment: amendment, amount: amount) }

    let(:amount) { 1.0 }

    describe '#amount_sign' do
      subject { modification.amount_sign }

      it { is_expected.to eq('+') }
    end

    describe '#amount_sign_human' do
      subject { modification.amount_sign_human }

      it { is_expected.to eq(:addition) }
    end

    describe '#abs_amount' do
      subject { modification.abs_amount }

      it { is_expected.to eq(1.0) }
    end
  end

  context 'when amount is negative' do
    let(:amount) { -1 }

    describe '#amount_sign' do
      subject { modification.amount_sign }

      it { is_expected.to eq('-') }
    end

    describe '#amount_sign_human' do
      subject { modification.amount_sign_human }

      it { is_expected.to eq(:removal) }
    end

    describe '#abs_amount' do
      subject { modification.abs_amount }

      it { is_expected.to eq(1.0) }
    end
  end
end
