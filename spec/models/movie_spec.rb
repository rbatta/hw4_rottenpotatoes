require 'spec_helper'

describe Movie do 
	describe 'all ratings method' do
		it 'should call all_ratings method' do
			Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
		end
	end

	describe 'find by director method' do 

		before :each do
			@mov = FactoryGirl.create(:movie)
			@mov1 = FactoryGirl.create(:movie)
			@mov2 = FactoryGirl.create(:movie, director: 'bob')
		end

		it 'should have a valid factory' do
			FactoryGirl.create(:movie).should be_valid
		end
		context 'when it has a director' do 
			it 'should return list of movies by similar directors' do
			  Movie.find_by_director(1).should == [@mov, @mov1]
			end
		end

		context "when it doesn't have a director" do 
			it 'should not return a list of movies by other directors' do 
				Movie.find_by_director(1).should_not == [@mov2]
			end
		end
	end
end