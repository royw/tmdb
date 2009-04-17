require 'spec_helper'

# Time to add your specs!
# http://rspec.info/

TMDB_API_KEY = '7a2f6eb9b6aa01651000f0a9324db835'

describe "TmdbMovie" do

  before(:all) do
    File.mkdirs(TMPDIR)
  end

  before(:each) do
    @profile = TmdbMovie.new('tt0465234', TMDB_API_KEY)
  end

  after(:each) do
    Dir.glob(File.join(TMPDIR,'tmdb_movie_spec*')).each { |filename| File.delete(filename) }
  end

  it "should find by imdb_id" do
    @profile.should_not == nil
  end

  it "should find tmdb id" do
    @profile.idents.first.should == '6637'
  end

  it "should find fanarts" do
    @profile.fanarts.size.should == 3
  end

  it "should find posters" do
    @profile.posters.size.should == 4
  end

  it "should find the tmdb url" do
    @profile.urls.first.should == 'http://www.themoviedb.org/movie/6637'
  end

  it "should find the imdb_id" do
    @profile.imdb_ids.first.should == 'tt0465234'
  end

  it "should find the title" do
    @profile.titles.first.should == 'National Treasure: Book of Secrets'
  end

  it "should find the short_overview" do
    @profile.short_overviews.first.should =~ /Benjamin Franklin Gates/
  end

  it "should find the type" do
    @profile.types.first.should == 'movie'
  end

  it "should find the alternative_titles" do
    @profile.alternative_titles.first.should == 'National Treasure 2'
  end

  it "should find the release" do
    @profile.releases.first.should == '2007-12-13'
  end

  it "should find the  score" do
    @profile.scores.first.should == '1.0'
  end

  it "should handle The Sand Pebble" do
    profile = TmdbMovie.new('tt0060934', TMDB_API_KEY)
    profile.idents.should be_nil
  end

end

