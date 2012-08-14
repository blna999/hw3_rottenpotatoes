require 'spec_helper'

describe MoviesController do
  describe 'find movies with same director' do
    it 'should call the model method that select the movies with same director' do
      fake_movie = mock('Movie', :director => 'Ridley Scott')
      Movie.stub(:find).and_return(fake_movie)
      Movie.should_receive(:find)
      Movie.should_receive(:find_all_by_director).with('Ridley Scott')
      post :find_similar, {:id => '3'}
    end
    it 'should select the Find Similar template for rendering' do
      fake_movie = mock('Movie', :director => 'Ridley Scott')
      Movie.stub(:find).and_return(fake_movie)
      Movie.stub(:find_all_by_director).and_return([mock('Movie'), mock('Movie')])
      post :find_similar, {:id => '3'}
      response.should render_template('find_similar')
    end
    it 'should make the movie list with same director' do
      fake_movie = mock('Movie', :director => 'Ridley Scott')
      Movie.stub(:find).and_return(fake_movie)
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_all_by_director).and_return(fake_results)
      post :find_similar, {:id => '3'}
      assigns(:movies).should == fake_results
    end
  end
end
