require 'spec_helper'

describe MoviesController do
  describe 'find movies with same director' do

  	context 'for movies that have a director' do 
	  	
	  	before :each do
	  		#m = mock('movie1', :title => 'Alien', :director => 'Ridley Scott')
	  		#@fake_movie = mock('Movie')
	  		#@fake_movie.stub(:title).and_return('Alien')
	  		#@fake_movie.stub(:director).and_return('Ridley Scott')
	  		#m = mock('movie2')
	  		#m.stub(:director).and_return('Ridley Scott')
	  		# this is to check for any code with m.director
	  		fake_movie = FactoryGirl.create(:movie)
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

	  	it 'should render a view to display matched movies' do
	  		#this checks that the view has an instance variable assigned by controller action
	  		fake_results = [mock('Movie'), mock('Movie')]
	  		Movie.stub(:find_by_director).and_return(fake_results)
		  	get :similar, {:id => '1'}
		  	assigns(:movies).should == fake_results  # the important line
	  	end

	  end # end context

	  context "for movies that don't have a director" do
	  end # end context

  end #end find movies
end #end describe moviescontroller