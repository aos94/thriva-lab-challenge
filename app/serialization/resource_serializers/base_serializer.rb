module ResourceSerializers
  class BaseSerializer
    class UnimplementedMethodError < StandardError; end

    def initialize(resource)
      @resource = resource
    end

    attr_reader :resource

    def serialize(include_attributes: true)
      item = { type: resource_type, id: resource.id }

      return item unless include_attributes

      item[:attributes] = attributes

      item
    end

    def resource_type
      raise UnimplementedMethodError
    end

    def attributes
      raise UnimplementedMethodError
    end
  end
end
