class SerializedRelation
  def initialize(relation:, resource:, include_attributes: false)
    @relation = relation
    @resource = resource
    @include_attributes = include_attributes
  end

  attr_reader :relation, :resource, :include_attributes

  def serialize
    loaded_relation = relation.load_for(resource)

    case relation.type
    when :collection
      SerializedCollection.new(
        resource_collection: loaded_relation,
        include_attributes: include_attributes,
        include_relationships: false
      ).serialize
    else
      [
        SerializedItem.new(
          resource: loaded_relation,
          include_attributes: include_attributes,
          include_relationships: false
        ).serialize
      ]
    end
  end
end
