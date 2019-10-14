# frozen_string_literal: true

require 'rails_helper'

describe Amendment do
  subject(:amendment) { build(:amendment, type: type) }

  let(:type) { 'Amendments::ArticulatedAmendment' }

  it { is_expected.to be_valid }

  context 'when has no type' do
    let(:type) { nil }

    it { is_expected.to be_invalid }
  end

  describe Amendments::ArticulatedAmendment do
    subject(:amendment) { build(:articulated_amendment) }

    it { is_expected.to be_valid }
    it { is_expected.to be_allow_articulated }
    it { is_expected.not_to be_allow_modifications }
    it { is_expected.not_to be_any_articulated }

    it 'type can be changed' do
      expect(amendment.type_cannot_be_changed).to be_truthy
    end

    context 'when has an articulated' do
      subject(:amendment) { create(:articulated_amendment, :with_articulated) }

      it { is_expected.to be_any_articulated }

      it 'type cannot be changed' do
        expect(amendment.type_cannot_be_changed).to be_nil
      end
    end
  end

  shared_examples 'an amendment that allow modifications' do
    it { is_expected.to be_valid }
    it { is_expected.not_to be_allow_articulated }
    it { is_expected.to be_allow_modifications }
    it { is_expected.not_to be_locked_type }
    it { is_expected.not_to be_any_section }
    it { is_expected.not_to be_any_modifications }

    it 'type can be changed' do
      expect(subject.type_cannot_be_changed).to be_truthy
    end
  end

  shared_examples 'an amendment with modifications' do
    it { is_expected.to be_locked_type }
    it { is_expected.to be_any_section }
    it { is_expected.to be_any_modifications }

    it 'type cannot be changed' do
      expect(subject.type_cannot_be_changed).to be_nil
    end
  end

  describe Amendments::StandardAmendment do
    subject(:amendment) { build(:standard_amendment) }

    it_behaves_like 'an amendment that allow modifications'

    context 'when has modifications' do
      subject(:amendment) { create(:standard_amendment, :with_modifications) }

      it_behaves_like 'an amendment with modifications'
    end
  end

  describe Amendments::TransferAmendment do
    subject(:amendment) { build(:transfer_amendment) }

    it_behaves_like 'an amendment that allow modifications'

    context 'when has modifications' do
      subject(:amendment) { create(:transfer_amendment, :with_modifications) }

      it_behaves_like 'an amendment with modifications'
    end
  end
end
