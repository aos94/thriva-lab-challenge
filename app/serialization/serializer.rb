module Serializer
  RESOURCE_SERIALIZERS = {
    TestPanel => ResourceSerializers::TestPanelSerializer,
    Test => ResourceSerializers::TestSerializer,
  }.freeze

  def self.for(resource)
    RESOURCE_SERIALIZERS.fetch(resource.class).new(resource)
  end
end
