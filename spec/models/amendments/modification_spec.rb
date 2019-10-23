# frozen_string_literal: true

require 'rails_helper'

describe Modification do
  subject(:modification) { build(:standard_modification, amendment: amendment) }

  let(:amendment) { create(:standard_amendment) }

  it { is_expected.to be_valid }

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

  context 'with amount that is negative' do
    subject(:modification) { build(:standard_modification, amendment: amendment, amount: amount) }

    let(:amount) { -1.0 }

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

  context 'with amount that is zero' do
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

      it { is_expected.to be_zero }
    end
  end

  context 'with amount that is nil' do
    subject(:modification) { build(:standard_modification, amendment: amendment, amount: amount) }

    let(:amount) { nil }

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

      it { is_expected.to be_zero }
    end

    context 'when amount_sign changes' do
      subject(:amount_sign_change) { modification.amount_sign = '-' }

      it { expect { amount_sign_change }.to change(modification, :amount) .from(0.0).to(-0.0) }
    end
  end

  context 'with abs_amount and positive amount_sign' do
    subject(:modification) { build(:standard_modification, amendment: amendment, abs_amount: abs_amount, amount_sign: amount_sign) }

    let(:abs_amount) { '1' }
    let(:amount_sign) { '+' }

    describe '#amount' do
      subject { modification.amount }

      it { is_expected.to eq(1.0) }
    end

    describe '#amount_sign_human' do
      subject { modification.amount_sign_human }

      it { is_expected.to eq(:addition) }
    end
  end

  context 'with abs_amount and negative amount_sign' do
    subject(:modification) { build(:standard_modification, amendment: amendment, abs_amount: abs_amount, amount_sign: amount_sign) }

    let(:abs_amount) { '1' }
    let(:amount_sign) { '-' }

    describe '#amount' do
      subject { modification.amount }

      it { is_expected.to eq(-1.0) }
    end

    describe '#amount_sign_human' do
      subject { modification.amount_sign_human }

      it { is_expected.to eq(:removal) }
    end
  end

  context 'with nil abs_amount and nil negative amount_sign' do
    subject(:modification) { build(:standard_modification, amendment: amendment, abs_amount: abs_amount, amount_sign: amount_sign) }

    let(:abs_amount) { nil }
    let(:amount_sign) { nil }

    describe '#amount' do
      subject { modification.amount }

      it { is_expected.to eq(0.0) }
    end

    describe '#amount_sign_human' do
      subject { modification.amount_sign_human }

      it { is_expected.to eq(:addition) }
    end
  end

  context 'when has no amendment' do
    let(:amendment) { nil }

    it { is_expected.to be_invalid }
  end

  context 'when amendment already has a modification' do
    let(:amendment) { create(:standard_amendment, :with_modifications) }

    it { is_expected.to be_locked_section }
  end

  context 'when abs_amount changes' do
    subject(:abs_amount_change) { modification.abs_amount = 2 }

    it { expect { abs_amount_change }.to change(modification, :amount) .from(1.0).to(2.0) }
    it { expect { abs_amount_change }.not_to change(modification, :amount_sign) }
  end

  context 'when amount changes to negative value' do
    subject(:amount_change_to_negative) { modification.amount = -2 }

    it { expect { amount_change_to_negative }.to change(modification, :abs_amount) .from(1.0).to(2.0) }
    it { expect { amount_change_to_negative }.to change(modification, :amount_sign) .from('+').to('-') }
  end

  context 'when amount changes to another positive value' do
    subject(:amount_change_to_positive) { modification.amount = 2 }

    it { expect { amount_change_to_positive }.to change(modification, :abs_amount) .from(1.0).to(2.0) }
    it { expect { amount_change_to_positive }.not_to change(modification, :amount_sign) }
  end

  context 'when amount_sign changes' do
    subject(:amount_sign_change) { modification.amount_sign = '-' }

    it { expect { amount_sign_change }.to change(modification, :amount) .from(1.0).to(-1.0) }
    it { expect { amount_sign_change }.not_to change(modification, :abs_amount) }
  end
end
