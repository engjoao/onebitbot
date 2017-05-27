require "pg_search"
include PgSearch

class Link < ActiveRecord::Base
  validates_presence_of :address

  has_many :faq_hashtags
  has_many :hashtags, through: :link_hashtags

  # include PgSearch
  pg_search_scope :search, :against => [:address]
end
