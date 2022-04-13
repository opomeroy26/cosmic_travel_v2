class ScientistWithPlanetsSerializerSerializer < ActiveModel::Serializer
  attributes :id, :name, :field_of_study, :avatar 

  has_many :planets 
end
