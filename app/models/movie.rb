class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
# class Movie::InvalidKeyError < StandardError ; end
  
#  def self.find_in_tmdb(string)
#    begin
#      Tmdb::Movie.find(string)
#    rescue NoMethodError => tmdb_gem_exception
#      if Tmdb::Api.response['code'] == '401'
#        raise Movie::InvalidKeyError, 'Invalid API key'
#      else
#        raise tmdb_gem_exception
#      end
#    end
#  end

end
