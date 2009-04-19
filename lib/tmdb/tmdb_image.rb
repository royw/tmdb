class TmdbImage
  attr_reader :imdb_id

  # imdb_id => String IMDB ID either with or without the 'tt' prefix
  # api_key => String containing the themovieDb.com API key
  # logger => nil or logger instance
  def initialize(ident, api_key, logger, filespec=nil)
    @imdb_id = 'tt' + ident.gsub(/^tt/, '') unless ident.blank?
    @api_key = api_key
    @logger = OptionalLogger.new(logger)
    @filespec = filespec
  end

  # return an Array of fanart sizes as Strings
  def fanart_sizes
    ['original', 'mid', 'thumb']
  end

  # return an Array of poster sizes as Strings
  def poster_sizes
    ['original', 'mid', 'thumb', 'cover']
  end

  # return nil or the source url to the given size (must be in fanart_sizes) fanart
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def fanart(size, dest_filespec=nil)
    src_url = nil
    if fanart_sizes.include?(size)
      src_url = image_url(@imdb_id, 'fanarts', size)
      copy_image(src_url, dest_filespec)
    end
    src_url
  end

  # return nil or the source url to the given size (must be in poster_sizes) poster
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def poster(size, dest_filespec=nil)
    src_url = nil
    if poster_sizes.include?(size)
      src_url = image_url(@imdb_id, 'posters', size)
      copy_image(src_url, dest_filespec)
    end
    src_url
  end

  # return nil or the source url to the 'original' size fanart
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def fanart_original(dest_filespec=nil)
    fanart('original', dest_filespec)
  end

  # return nil or the source url to the 'mid' size fanart
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def fanart_mid(dest_filespec=nil)
    fanart('mid', dest_filespec)
  end

  # return nil or the source url to the 'thumb' size fanart
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def fanart_thumb(dest_filespec=nil)
    fanart('thumb', dest_filespec)
  end

  # return nil or the source url to the 'original' size poster
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def poster_original(dest_filespec=nil)
    poster('original', dest_filespec)
  end

  # return nil or the source url to the 'mid' size poster
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def poster_mid(dest_filespec=nil)
    poster('original', dest_filespec)
  end

  # return nil or the source url to the 'thumb' size poster
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def poster_thumb(dest_filespec=nil)
    poster('original', dest_filespec)
  end

  # return nil or the source url to the 'cover' size poster
  # optionally save the image to dest_filespec unless dest_filespec is nil
  def poster_cover(dest_filespec=nil)
    poster('original', dest_filespec)
  end

  protected

  # find the URL to the image
  # imdb_id => IMDB ID with or without 'tt' prefix
  # type => either 'fanart' or 'poster' String
  # size => member of either fanart_sizes or poster_sizes
  def image_url(imdb_id, type, size)
    src_url = nil
    profile = TmdbProfile.first(:imdb_id => imdb_id, :api_key => @api_key, :filespec => @filespec, :logger => @logger)
    indexes = {}
    unless profile.nil? || profile.movie.blank?
      movie = profile.movie
      unless movie[type].blank?
        images = movie[type]
        images.each do |image|
          image_size = image['size']
          image_size = image_size.first if image_size.respond_to?('first')
          if image_size == size
            @logger.debug { "#{image.inspect}" }
            src_url = image['content']
          end
          break unless src_url.blank?
        end
      end
    end
    src_url
  end

  # download the fanart
  # returns nil if no attempt to copy was made, 0 on error, or the image size in bytes on success
  def copy_image(src_url, dest_filespec)
    @logger.debug { "copy_image(#{src_url}, #{dest_filespec})" }
    image_size = nil
    unless src_url.blank? || dest_filespec.blank?
      begin
        image_size = 0
        extension = File.extname(src_url)
        unless extension.blank?
          dest_filespec += extension
        end
        unless File.exist?(dest_filespec) && (File.size(dest_filespec) > 0)
          @logger.info { "Downloading: #{src_url}" }
          data = fetch(src_url.escape_unicode)
          File.open(dest_filespec, 'w') do |file|
            file.print(data)
          end
        end
        image_size = File.size(dest_filespec)
      rescue Exception => e
        @logger.error { "Error fetching image.\n  src_url => #{src_url},\n  dest_filespec => #{dest_filespec}\n  #{e.to_s}" }
      end
    end
    image_size
  end

  MAX_ATTEMPTS = 3
  SECONDS_BETWEEN_RETRIES = 1.0

  # fetch the page retrying on error up to MAX_ATTEMPTS with a pause
  # of SECONDS_BETWEEN_RETRIES seconds between retries
  def fetch(page)
    doc = nil
    attempts = 0
    begin
      doc = read_page(page)
    rescue Exception => e
      attempts += 1
      if attempts > MAX_ATTEMPTS
        raise
      else
        sleep SECONDS_BETWEEN_RETRIES
        retry
      end
    end
    doc
  end

  # makes reading from cache during specs possible
  def read_page(src_url)
    open(src_url).read
  end

end
