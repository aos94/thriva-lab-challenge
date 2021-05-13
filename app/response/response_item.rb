class ResponseItem
  def initialize(resource:, includes: [])
    @resource = resource
    @includes = includes
  end

  attr_reader :resource, :includes

  def call
    response_item = { data: SerializedItem.new(resource: resource).serialize }

    return response_item unless includes.any?

    response_item.merge(
      included: includes.map do |include_type|
        SerializedRelation.new(
          resource: resource,
          relation: Relations.get_for!(resource, include_type),
          include_attributes: true
        ).serialize
      end.flatten
    )
  end
end
