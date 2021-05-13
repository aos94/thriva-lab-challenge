require_relative "base_serializer"

module ResourceSerializers
  class TestPanelSerializer < BaseSerializer
    RESOURCE_TYPE = "test_panels"

    def resource_type
      RESOURCE_TYPE
    end

    def attributes
      {
        price: resource.price,
        sample_tube_types: resource.sample_tube_types,
        sample_volume_requirement: resource.sample_volume_requirement,
      }
    end
  end
end
