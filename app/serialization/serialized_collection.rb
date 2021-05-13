class SerializedCollection
  def initialize(resource_collection:, include_attributes: true, include_relationships: true)
    @resource_collection = resource_collection
    @include_attributes = include_attributes
    @include_relationships = include_relationships
  end

  attr_reader :resource_collection, :include_attributes, :include_relationships

  def serialize
    resource_collection.map do |resource|
      SerializedItem.new(
        resource: resource,
        include_attributes: include_attributes,
        include_relationships: include_relationships,
      ).serialize
    end
  end
end
