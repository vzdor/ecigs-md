class Asset < ActiveRecord::Base
  has_attached_file :blob, :styles => {
    :thumb => "70x70#",
    :large => "700x700>"
  }

  belongs_to :attachable, :polymorphic => true
end
