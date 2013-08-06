class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile

  belongs_to :description_object, property: :is_part_of
end