class MixtureProduct < ActiveRecord::Base
  belongs_to :mixture

  belongs_to :product
end
