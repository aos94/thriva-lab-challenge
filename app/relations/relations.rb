module Relations
  Relation = Value.new(:name, :resource_class, :method_name, :type) do
    # TODO: Validate that method_name & type are compatible
    def load_for(resource)
      return unless resource.class == resource_class

      resource.send(method_name)
    end
  end

  RELATION_DEFINITIONS = {
    TestPanel => [
      Relation.with(
        name: :test, method_name: :tests,
        resource_class: TestPanel, type: :collection
      ),
    ],
  }.freeze

  RELATIONS_LOOKUP = RELATION_DEFINITIONS.transform_values do |definition|
    definition.index_by(&:name)
  end.freeze

  def self.for(resource)
    RELATION_DEFINITIONS.fetch(resource.class, [])
  end

  def self.exists_for?(resource_class, relation_name)
    RELATIONS_LOOKUP.fetch(resource_class).has_key?(relation_name.to_sym)
  end

  def self.get_for!(resource, relation_name)
    RELATIONS_LOOKUP[resource.class].fetch(relation_name.to_sym)
  end
end
