require "rails_helper"

describe SerializedRelation do
  let(:instance) do
    described_class.new(
      relation: relation,
      resource: resource,
      include_attributes: include_attributes,
    )
  end

  let(:resource) { TestPanel.find(resource_id) }
  let(:resource_id) { "TP3" }
  let(:include_attributes) { true }
  let(:relation) do
    Relations::RELATION_DEFINITIONS[TestPanel].find { |r| r.name == :test }
  end

  describe "#serialize" do
    subject(:item) { instance.serialize }

    it "returns a serialized representation of the relations of the supplied resource" do
      expect(item).to eq([
        {
          type: "test",
          id: "LFT",
          attributes: {
            name: "Liver function",
            sample_tube_type: :yellow,
            sample_volume_requirement: 60
          },
        },
        {
          type: "test",
          id: "VITD",
          attributes: {
            name: "Vitamin D",
            sample_tube_type: :yellow,
            sample_volume_requirement: 120,
           },
        },
        {
          type: "test",
          id: "CHO",
          attributes: {
            name: "Cholesterol",
            sample_tube_type: :yellow,
            sample_volume_requirement: 100,
          },
        },
      ])
    end
  end
end
