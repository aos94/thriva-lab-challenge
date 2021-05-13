module ResourceSerializers
  class TestSerializer < BaseSerializer
    RESOURCE_TYPE = "test"

    def resource_type
      RESOURCE_TYPE
    end

    def attributes
      {
        name: resource.name,
        sample_tube_type: resource.sample_tube_type,
        sample_volume_requirement: resource.sample_volume_requirement,
      }
    end
  end
end
