# frozen_string_literal: true

require 'rails_helper'

describe Modification do
  subject(:modification) { build(:addition_modification, amendment: amendment) }

  let(:amendment) { create(:standard_amendment) }

  it { is_expected.to be_valid }
  it { is_expected.not_to be_locked_section }
  it { is_expected.not_to be_locked_organism }
  it { is_expected.not_to be_locked_program(Modifications::Addition) }
  it { is_expected.not_to be_locked_program(Modifications::Removal) }

  context 'when amendment already has a modification' do
    let(:amendment) { create(:standard_amendment, :with_modifications) }

    it { is_expected.to be_locked_section }
    it { is_expected.not_to be_locked_organism }
    it { is_expected.to be_locked_program(Modifications::Addition) }
    it { is_expected.not_to be_locked_program(Modifications::Removal) }
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

  shared_examples 'a modification without extra fields' do
    it { is_expected.not_to be_use_field(:amount) }
    it { is_expected.not_to be_use_field(:project) }
    it { is_expected.not_to be_use_field(:project_new) }
  end

  describe Modifications::Addition do
    subject { described_class }

    it { is_expected.to be_use_field(:amount) }
    it { is_expected.to be_use_field(:project) }
    it { is_expected.to be_use_field(:project_new) }
  end

  describe Modifications::Removal do
    subject { described_class }

    it { is_expected.to be_use_field(:amount) }
    it { is_expected.to be_use_field(:project) }
    it { is_expected.not_to be_use_field(:project_new) }
  end

  [Modifications::OrganismBudgetIncome, Modifications::OrganismBudgetExpenditure].each do |klass|
    describe klass do
      subject { described_class }

      it_behaves_like 'a modification without extra fields'
    end
  end
end
