# frozen_string_literal: true

require 'rails_helper'

describe Section do
  subject(:section) { build(:section, ref: '1', title: 'Testing full title') }

  it { is_expected.to be_valid }

  context 'when has full title' do
    let(:ref) { '1' }
    let(:title) { 'Testing full title' }

    it 'has valid full title' do
      expect(subject.full_title).to eq "01. Testing full title"
    end
  end
end
