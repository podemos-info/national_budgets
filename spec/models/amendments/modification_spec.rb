# frozen_string_literal: true

require 'rails_helper'

describe Modification do
  subject(:modification) { build(:standard_modification, amendment: amendment) }

  let(:amendment) { create(:standard_amendment) }

  it { is_expected.to be_valid }

  context 'when amendment already has a modification' do
    let(:amendment) { create(:standard_amendment, :with_modifications) }

    it { is_expected.to be_locked_section }
  end
end
