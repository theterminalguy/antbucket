require 'rails_helper'

RSpec.describe Paginator do
  describe '#limit' do
    it do
      allow(Paginator).to receive(:limit).with(1).and_return(true)
    end
  end

  describe '#decode' do
    it do
      allow(Paginator).to receive(:page).with(1).and_return(true)
    end
  end

  describe '#total_pages' do
    it do
      allow(Paginator).to receive(:total_pages).with(30).and_return(true)
    end
  end
end
