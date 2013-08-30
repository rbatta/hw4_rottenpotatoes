require 'spec_helper'

describe MoviesController do
	before { @fake_movie = FactoryGirl.create(:movie) }

  describe 'find movies with same director' do

  	context 'for movies that have a director' do 
	  	
	  	#before :each do
	  		#m = mock('movie1', :title => 'Alien', :director => 'Ridley Scott')
	  		#@fake_movie = mock('Movie')
	  		#@fake_movie.stub(:title).and_return('Alien')
	  		#@fake_movie.stub(:director).and_return('Ridley Scott')
	  		#m = mock('movie2')
	  		#m.stub(:director).and_return('Ridley Scott')
	  		# this is to check for any code with m.director
	  		#fake_movie = FactoryGirl.create(:movie)
	  	#end #end before
	  	
	  	it 'should call the model method in controller action' do
	  		# should_receive is a mock method just to check if the controller action calls the method
	  		# regardless of it working or not
	  		# route is :controller, :action, :id so needs some sort of id value
	  		# therefore, the should_recv find by dir needs to return with id: 1
	  		Movie.should_receive(:find_by_director).with('1').and_return(@fake_movie)
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

	  	it 'should display flash notice and redirect appropriately' do
	  		m = FactoryGirl.create(:movie, :director => "")
	  		Movie.should_receive(:find).with('1').and_return(m)
	  		get :similar, {:id => 1}
	  		flash[:notice].should_not be_nil
	  		response.should redirect_to(movies_path)
	  	end

	  end #end context
  end #end find movies

  describe 'show controller action' do
  	it 'should show movie' do
  		get :show, { id: '1'}
  		response.should render_template('show')
  	end
  end

  describe 'index controller action' do
  	it 'should show index page' do
  		get :index
  		response.should render_template('index')
  	end

  	it 'should show selected ratings' do
  		get :index, {:ratings => {'G' => 1, 'PG' => 1}}
  		response.should redirect_to(movies_path(:ratings => {'G' => 1, 'PG' => 1}))
  	end

  	it 'should show ratings and be sorted' do
  		get :index, {:ratings => {'G' => 1}, sort: 'release_date'}
  		response.should redirect_to(movies_path(sort: 'release_date', :ratings => {'G' => 1}))
  	end

  	it 'should sort by title' do
  		get :index, {sort: 'title', :ratings => {'PG' => 1}}
  		response.should redirect_to(movies_path(sort: 'title', :ratings => {'PG' => 1}))
  	end

  end

 	describe 'new controller action' do
 		it 'should render new movie page' do
 			get :new
 			response.should render_template('new')
 		end
 	end

 	describe 'create controller action' do
 		it 'should call create method' do
	 		post :create
	 		response.should redirect_to(movies_path)
	 	end
 	end

 	describe 'edit controller action' do
 		it 'should display movie info' do
 			Movie.should_receive(:find).with('1')
 			get :edit, {:id => '1'}
 		end
 	end

 	describe 'update controller action' do
	 	it 'should be responsive' do	
	 		get :update, { id: '1'}
	 		response.should redirect_to(movie_path)
	 	end
 	end

 	# ACTUAL SPEC WAY TO CHECK UPDATE CONTROLLER ACTION
 	describe 'update action' do

    it 'calls the update attributes method' do
    	#http://stackoverflow.com/questions/9967113/rspec-testing-for-update-controller-not-working
    	fake_rating = 'PG-15'
    	Movie.stub(:find).and_return(@fake_movie)
      @fake_movie.should_receive(:update_attributes!).with("rating" => fake_rating).and_return(:true)
      put :update, :id => @fake_movie.id, movie: {rating: fake_rating}
    end

    it 'redirects to movie show page' do
      put :update, :id => @fake_movie.id
      response.should redirect_to(movie_path(@fake_movie))
    end
  end

 	describe 'destroy controller action' do
 		it 'should delete a movie' do
 			get :destroy, {id: '1'}
 			response.should redirect_to(movies_path)
 		end
 	end


end #end describe moviescontroller