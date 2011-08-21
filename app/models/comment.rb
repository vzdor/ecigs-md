class Comment < ActiveRecord::Base
  paginates_per 15

  belongs_to :user

  belongs_to :commentable, :polymorphic => true

  validates_presence_of :content

  validates_presence_of :fullname

  validates_numericality_of :score, :less_than => 6, :greater_than_or_equal_to => 0

  attr_accessible :content, :fullname, :score

  attr_accessor :fullname

  after_save :save_fullname

  def fullname
    @fullname || user.fullname
  end

  class << self
    def new_by(user)
      comment = self.new
      comment.user = user
      comment
    end
  end

  scope :recent, order("created_at desc")

  protected

  def save_fullname
    unless user.fullname == fullname
      user.fullname = fullname
      user.save!
    end
  end

end
