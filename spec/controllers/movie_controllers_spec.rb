require 'spec_helper'

describe 'MovieController' do
  describe 'loading rotten potatoes' do
  	it 'should load all movies' do
  		get :index
  	end
  end
end