require 'spec_helper'

describe Movie do 
	describe 'all ratings method' do
		it 'should call all_ratings method' do
			Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
		end
	end

	describe 'find by director method' do 
		it 'should return something' do
			Movie.find_by_director(1).should eql(Movie.find(1))
		end

		it 'should return list of movies by similar directors'
		it 'should not return a list of movies by other directors'
	end
end