require 'spec_helper'

describe Movie do 
	describe 'all ratings method' do
		it 'should call all_ratings method' do
			Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
		end
	end
end