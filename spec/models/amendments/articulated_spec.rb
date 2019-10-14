# frozen_string_literal: true

require 'rails_helper'

describe Articulated do
  subject(:articulated) { build(:final_articulated, amendment: amendment) }

  let(:amendment) { create(:articulated_amendment) }

  it { is_expected.to be_valid }

  context 'when amendment already has an articulated' do
    let(:amendment) { create(:articulated_amendment, :with_articulated) }

    it { is_expected.to be_invalid }
  end
end
