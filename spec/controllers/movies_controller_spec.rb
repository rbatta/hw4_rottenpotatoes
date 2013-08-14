require 'spec_helper'

describe MoviesController do
  describe 'find movies with same director' do

  	context 'for movies that have a director' do 
	  	
	  	before :each do
	  		#@fake_movie = mock('Movie')
	  		#@fake_movie.stub(:title).and_return('Alien')
	  		#@fake_movie.stub(:director).and_return('Ridley Scott')
	  		@fake_movie = FactoryGirl.create(:movie)
	  	end #end before
	  	
	  	it 'should call the model method in controller action' do
	  		# should_receive is a mock method just to check if the controller action calls the method
	  		# regardless of it working or not
	  		# route is :controller, :action, :id so needs some sort of id value
	  		# therefore, the should_recv find by dir needs to return with id: 1
	  		# technically this isn't what we want the code to do...
	  		Movie.should_receive(:find_by_director).with('1')
	  	  get :similar, {:id => "1"}  
	  	end #end it

	  	it 'should select similar movies for rendering' do
	  		# since find by director totally doesn't exist, its stubbed out
	  		# says that its a fake method so there is something to call but 
	  		# whether or not it gets called doesn't matter at all
	  		Movie.stub(:find_by_director) 
	  		get :similar, {:id => '1'}
	  		response.should render_template("similar") # this bit is what this spec is testing
	  	end

	  	it 'should grab the id of the current movie'

	  	it 'should render a view to display matched movies' do
		  	get :similar, {:id => '1'}
		  	response.should render_template("similar")
	  	end

	  end # end context

	  context "for movies that don't have a director" do
	  end # end context

  end #end find movies
end #end describe moviescontroller