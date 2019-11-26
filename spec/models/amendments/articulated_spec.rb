# frozen_string_literal: true

require 'rails_helper'

describe Articulated do
  subject(:articulated) { build(:standard_articulated, amendment: amendment) }

  let(:amendment) { create(:articulated_amendment) }

  it { is_expected.to be_valid }
  it { is_expected.to be_articulated_number }

  describe Articulateds::StandardArticulated do
    subject(:articulated) { build(:additional_articulated, amendment: amendment) }

    let(:amendment) { create(:articulated_amendment) }

    it { is_expected.to be_valid }
    it { is_expected.not_to be_articulated_number }
  end

  describe Articulateds::FinalArticulated do
    subject(:articulated) { build(:final_articulated, amendment: amendment) }

    let(:amendment) { create(:articulated_amendment) }

    it { is_expected.to be_valid }
    it { is_expected.not_to be_articulated_number }
  end
end
