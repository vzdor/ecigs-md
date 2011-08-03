class WikiPage < ActiveRecord::Base
  acts_as_taggable

  before_validation :set_slug

  validates_presence_of :title

  validates_presence_of :content

  validates_uniqueness_of :slug

  scope :visible, where(:is_visible => true)

  def to_param
    slug
  end

  class << self
    def slug(title)
      "#{title.scan(/\w+/).join('-').mb_chars.downcase.to_s}"
    end
  end

  protected

  def set_slug
    self.slug = self.class.slug(title)
  end
end
