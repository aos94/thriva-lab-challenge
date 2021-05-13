class SerializedItem
  def initialize(resource:, include_attributes: true, include_relationships: true)
    @resource = resource
    @serializer = Serializer.for(resource)
    @include_attributes = include_attributes
    @include_relationships = include_relationships
  end

  attr_reader :resource, :serializer, :include_attributes, :include_relationships

  def serialize
    serialized_item = serializer.serialize(include_attributes: include_attributes)

    return serialized_item unless include_relationships

    relationships = serialize_relationships

    return serialized_item unless relationships.any?

    serialized_item.merge(relationships: relationships)
  end

  private

  def serialize_relationships
    relations_for_resource = Relations.for(resource)

    return [] unless relations_for_resource.any?

    serialized_relations = {}

    relations_for_resource.each do |relation|
      serialized_relations[relation.name] = {
        data: SerializedRelation.new(relation: relation, resource: resource).serialize
      }
    end

    serialized_relations
  end
end
