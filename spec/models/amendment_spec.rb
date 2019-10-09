# frozen_string_literal: true

require 'rails_helper'

describe Amendment do # rubocop:disable Metrics/BlockLength
  describe Amendments::ArticulatedAmendment do
    subject(:articulated_amendment) { build(:articulated_amendment, **params) }

    let(:params) { {} }

    it { is_expected.to be_valid }
    it { is_expected.to be_allow_articulated }

    context 'when type is nil' do
      let(:params) { { type: nil } }

      it { is_expected.to be_invalid }
    end

    context 'when has articulated' do
      subject(:articulated_amendment_with_articulated) { create(:articulated_amendment_with_articulated) }

      it { is_expected.to be_articulated }
    end
  end

  describe Amendments::StandardAmendment do
    subject(:standard_amendment) { build(:standard_amendment, **params) }

    let(:params) { {} }

    it { is_expected.to be_valid }
    it { is_expected.to be_allow_modifications }

    context 'when type is nil' do
      let(:params) { { type: nil } }

      it { is_expected.to be_invalid }
    end

    context 'when has modifications' do
      subject(:standard_amendment_with_modifications) { create(:standard_amendment_with_modifications) }

      it { is_expected.to be_locked_type }
      it { is_expected.to be_section }
    end
  end

  describe Amendments::TransferAmendment do
    subject(:transfer_amendment) { build(:transfer_amendment, **params) }

    let(:params) { {} }

    it { is_expected.to be_valid }
    it { is_expected.to be_allow_modifications }

    context 'when type is nil' do
      let(:params) { { type: nil } }

      it { is_expected.to be_invalid }
    end

    context 'when has modifications' do
      subject(:tramsfer_amendment_with_modifications) { create(:transfer_amendment_with_modifications) }

      it { is_expected.to be_locked_type }
      it { is_expected.to be_section }
    end
  end
end
