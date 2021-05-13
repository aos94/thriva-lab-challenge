require "rails_helper"

describe SerializedCollection do
  let(:instance) do
    described_class.new(
      resource_collection: resource_collection,
      include_attributes: include_attributes,
      include_relationships: include_relationships,
    )
  end

  let(:resource_collection) { resource_ids.map { |id| TestPanel.find(id) } }
  let(:resource_ids) { ["TP1", "TP3"] }
  let(:include_attributes) { true }
  let(:include_relationships) { true }

  describe "#serialize" do
    subject(:collection) { instance.serialize }

    it "returns an array of serialized representations of the supplied resource" do
      expect(collection).to match([
        {
          type: "test_panels",
          id: "TP1",
          attributes: instance_of(Hash),
          relationships: instance_of(Hash),
        },
        {
          type: "test_panels",
          id: "TP3",
          attributes: instance_of(Hash),
          relationships: instance_of(Hash),
        },
      ])
    end

    context "when relationships are not included" do
      let(:include_relationships) { false }

      it "doesn't include relationships in the serialized item representations" do
        expect(collection).to match([
          {
            type: "test_panels",
            id: "TP1",
            attributes: instance_of(Hash),
          },
          {
            type: "test_panels",
            id: "TP3",
            attributes: instance_of(Hash),
          },
        ])
      end
    end

    context "when attributes are not included" do
      let(:include_attributes) { false }

      it "doesn't include attributes in the serialized item representations" do
        expect(collection).to match([
          {
            type: "test_panels",
            id: "TP1",
            relationships: instance_of(Hash),
          },
          {
            type: "test_panels",
            id: "TP3",
            relationships: instance_of(Hash),
          },
        ])
      end
    end
  end
end
