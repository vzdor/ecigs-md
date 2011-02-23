class Asset < ActiveRecord::Base
  has_attached_file :blob, :styles => {
    :thumb => "100x100#",
    :large => "600x600>"
  }

  belongs_to :attachable, :polymorphic => true
end
