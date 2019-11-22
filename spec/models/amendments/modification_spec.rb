# frozen_string_literal: true

require 'rails_helper'

describe Modification do
  subject(:modification) { build(:addition_modification, amendment: amendment) }

  let(:amendment) { create(:standard_amendment) }

  it { is_expected.to be_valid }
  it { is_expected.not_to be_locked_section }

  context 'when amendment already has a modification' do
    let(:amendment) { create(:standard_amendment, :with_modifications) }

    it { is_expected.to be_locked_section }
  end

  context 'when amendment has only one modification and section changes' do
    subject(:section_changes) { modification.section = create(:section, budget: modification.budget) }

    it { expect { section_changes }.not_to change(modification, :locked_section?) }
    it { expect { section_changes }.not_to change(modification, :valid?) }
  end

  context 'when has no amendment' do
    let(:amendment) { nil }

    it { is_expected.to be_invalid }
  end
end
