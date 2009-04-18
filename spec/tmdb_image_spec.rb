require 'spec_helper'
require 'tempfile'

require 'ruby-debug'

# Time to add your specs!
# http://rspec.info/

TMDB_API_KEY = '7a2f6eb9b6aa01651000f0a9324db835'

describe "TmdbImage" do

  before(:all) do
    @logger = nil
    File.mkdirs(TMPDIR)
  end

  before(:each) do
    # tt0465234 => National Treasure: Book of Secrets
    @image = TmdbImage.new('tt0465234', TMDB_API_KEY, @logger)
  end

  after(:each) do
    Dir.glob(File.join(TMPDIR,'tmdb_image_spec*')).each { |filename| File.delete(filename) }
  end

  it "should find by imdb_id" do
    @image.should_not == nil
  end

  it "should find image via profile" do
    profile = TmdbProfile.first(:imdb_id => 'tt0465234', :api_key => TMDB_API_KEY, :logger => @logger)
    profile.image.imdb_id.should == 'tt0465234'
  end

  it "should find image via movie" do
    profile = TmdbMovie.new('0465234', TMDB_API_KEY, @logger)
    profile.image.imdb_id.should == 'tt0465234'
  end

  it "should find original size fanart" do
    src_url = nil
    src_url = @image.fanart_original unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find mid size fanart" do
    src_url = nil
    src_url = @image.fanart_mid unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find thumb size fanart" do
    src_url = nil
    src_url = @image.fanart_thumb unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find original size poster" do
    src_url = nil
    src_url = @image.poster_original unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find mid size poster" do
    src_url = nil
    src_url = @image.poster_mid unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find thumb size poster" do
    src_url = nil
    src_url = @image.poster_thumb unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find cover size poster" do
    src_url = nil
    src_url = @image.poster_cover unless @image.nil?
    src_url.should_not be_nil
  end

  it "should find all fanarts" do
    buf = []
    @image.fanart_sizes.each do |size|
      buf << "fanart(#{size}) returned nil" if @image.fanart(size).nil?
    end
    puts buf.join("\n") unless buf.empty?
    buf.empty?.should be_true
  end

  it "should find all posters" do
    buf = []
    @image.poster_sizes.each do |size|
      buf << "poster(#{size}) returned nil" if @image.poster(size).nil?
    end
    puts buf.join("\n") unless buf.empty?
    buf.empty?.should be_true
  end

  # the same routine is used by all the getters to fetch the image so only
  # need to test one case
  it "should fetch fanart" do
    filespec = get_temp_filename
    src_url = @image.fanart_original(filespec)
    filespec += File.extname(src_url)
    (File.exist?(filespec).should be_true) && (File.size(filespec).should > 0)
  end

  # these are a couple of white box tests to show a bug where
  # src_url was nil but copy_image was trying to copy from it anyway.

  it "should not attempt to copy if src_url is blank" do
    dest_filespec = get_temp_filename
    @image.send('copy_image', nil, dest_filespec).should be_nil
  end

  it "should not attempt to copy if dest_filespec is blank" do
    src_url = @image.send('image_url', 'tt0465234', 'fanarts', 'original')
    @image.send('copy_image', src_url, nil).should be_nil
  end

  def get_temp_filename
    outfile = Tempfile.new('tmdb_image_spec', TMPDIR)
    filespec = outfile.path
    outfile.unlink
    filespec
  end

end

