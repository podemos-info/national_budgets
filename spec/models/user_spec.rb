# frozen_string_literal: true

require 'rails_helper'

describe User do
  subject(:user) { build(:user, **params) }

  let(:params) { {} }

  it { is_expected.to be_valid }

  context 'with a email that is nil' do
    let(:params) { { email: nil } }

    it { is_expected.to be_invalid }
  end
end
