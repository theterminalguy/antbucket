require 'rails_helper'

RSpec.describe Paginator do
  describe '#limit' do
    context 'when no value is given' do 
      it 'returns 20' do 
        expect(
          Paginator.limit
          ).to eq 20 
      end 
    end  

    context 'when value is less than 20' do 
      it 'returns 20' do 
        expect(
          Paginator.limit(1)
        ).to eq 20 
      end 
    end

    context 'when value is greater than 20' do 
      it 'returns value' do 
        expect(
          Paginator.limit(25)
        ).to eq 25 
      end 
    end 

    context 'when values is greater than 100' do 
      it 'returns 100' do 
        expect(
          Paginator.limit(101)
        ).to eq 100
      end 
    end 
  end

  describe '#total_pages' do 
    context 'if value is less than 20' do 
      it 'returns 1' do 
      expect(
        Paginator.total_pages(10)
        ).to eq 1
      end 
    end 

    context 'when value is a factor of 20 e.g. 40' do 
      it 'returns 2' do
        expect(
          Paginator.total_pages(40)
        ).to eq 2  
      end 
    end 

    context 'when vaue is not a factor of 20 e.g 21' do 
      it 'returns 2' do 
        expect(
          Paginator.total_pages(21)
        ).to eq 2 
      end 
    end 
  end 
end
