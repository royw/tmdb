require 'spec_helper'
require 'tempfile'

# Time to add your specs!
# http://rspec.info/

TMDB_API_KEY = '7a2f6eb9b6aa01651000f0a9324db835'

describe "TmdbProfile" do

  before(:all) do
    File.mkdirs(TMPDIR)
  end

  before(:each) do
    # tt0465234 => National Treasure: Book of Secrets
    @profile = TmdbProfile.first(:imdb_id => 'tt0465234', :api_key => TMDB_API_KEY)
  end

  after(:each) do
    Dir.glob(File.join(TMPDIR,'tmdb_profile_spec*')).each { |filename| File.delete(filename) }
  end

  describe "Finder" do
    it "should find by imdb_id" do
      @profile.should_not == nil
    end
  end

  describe "Contents" do
    it "should find tmdb id" do
      @profile.movie['idents'].first.should == '6637'
    end

    it "should find fanarts" do
      @profile.movie['fanarts'].size.should == 3
    end

    it "should find posters" do
      @profile.movie['posters'].size.should == 4
    end

    it "should find the tmdb url" do
      @profile.movie['urls'].first.should == 'http://www.themoviedb.org/movie/6637'
    end

    it "should find the imdb_id" do
      @profile.movie['imdb_ids'].first.should == 'tt0465234'
    end

    it "should find the title" do
      @profile.movie['titles'].first.should == 'National Treasure: Book of Secrets'
    end

    it "should find the short_overview" do
      @profile.movie['short_overviews'].first.should =~ /Benjamin Franklin Gates/
    end

    it "should find the type" do
      @profile.movie['types'].first.should == 'movie'
    end

    it "should find the alternative_titles" do
      @profile.movie['alternative_titles'].first.should == 'National Treasure 2'
    end

    it "should find the release" do
      @profile.movie['releases'].first.should == '2007-12-13'
    end

    it "should find the  score" do
      @profile.movie['scores'].first.should == '1.0'
    end
  end

  describe "XML" do
    it "should be able to convert to xml" do
      xml = @profile.to_xml
      (xml.should_not be_nil) && (xml.length.should > 0)
    end

    it "should be able to convert to xml and then from xml" do
      hash = nil
      begin
        xml = @profile.to_xml
        hash = XmlSimple.xml_in(xml)
      rescue
        hash = nil
      end
      hash.should_not be_nil
    end
  end

  describe "File" do
    it "should save the profile to a file" do
      filespec = get_temp_filename
      profile = TmdbProfile.first(:imdb_id => 'tt0465234', :api_key => TMDB_API_KEY, :filespec => filespec)
      (File.exist?(filespec).should be_true) && (File.size(filespec).should > 0)
    end

    # now let's test caching the profile to/from a file

    it "should not create a file if a :filespec option is passed that is nil" do
      profile = TmdbProfile.first(:imdb_id => 'tt0465234', :api_key => TMDB_API_KEY, :filespec => nil)
      Dir.glob(File.join(TMPDIR, "imdb_profile_spec*")).empty?.should be_true
    end

    it "should create a file if a :filespec option is passed" do
      filespec = get_temp_filename
      profile = TmdbProfile.first(:imdb_id => 'tt0465234', :api_key => TMDB_API_KEY, :filespec => filespec)
      (File.exist?(filespec) && (File.size(filespec) > 0)).should be_true
    end

    it "should load from a file if a :filespec option is passed and the file exists" do
      filespec = get_temp_filename
      profile1 = TmdbProfile.first(:imdb_id => 'tt0465234', :api_key => TMDB_API_KEY, :filespec => filespec)
      profile2 = TmdbProfile.first(:api_key => TMDB_API_KEY, :filespec => filespec)
      profile1.imdb_id.should == profile2.imdb_id
    end

    it "should not load from a file if a :filespec option is passed and the file does not exists" do
      filespec = get_temp_filename
      profile = TmdbProfile.first(:api_key => TMDB_API_KEY, :filespec => filespec)
      profile.should be_nil
    end
  end


  def get_temp_filename
    outfile = Tempfile.new('tmdb_profile_spec', TMPDIR)
    filespec = outfile.path
    outfile.unlink
    filespec
  end

end

