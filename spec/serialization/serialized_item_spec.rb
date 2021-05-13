require "rails_helper"

describe SerializedItem do
  let(:instance) do
    described_class.new(
      resource: resource,
      include_attributes: include_attributes,
      include_relationships: include_relationships
    )
  end

  let(:resource) { TestPanel.find("TP3") }
  let(:resource_id) { "TP3" }
  let(:include_attributes) { true }
  let(:include_relationships) { true }

  let(:resource_attributes) do
    {
      price: 1800,
      sample_tube_types: [:yellow, :yellow, :yellow],
      sample_volume_requirement: 280,
    }
  end

  describe "#serialize" do
    subject(:item) { instance.serialize }

    it "returns a serialized representation of the supplied resource" do
      expect(item).to eq({
        type: "test_panels",
        id: resource_id,
        attributes: resource_attributes,
        relationships: {
          test: {
            data: [
              { type: "test", id: "LFT" },
              { type: "test", id: "VITD" },
              { type: "test", id: "CHO" }
            ]
          }
        }
      })
    end

    context "when the resource does not have relationships" do
      let(:resource) { Test.find(resource_id) }
      let(:resource_id) { "CHO" }

      let(:resource_attributes) do
        {
          name: "Cholesterol",
          sample_tube_type: :yellow,
          sample_volume_requirement: 100,
        }
      end

      it do
        expect(item).to_not have_key(:relationships)
      end

      it "still returns a serialized representation of the resource" do
        expect(item).to eq({
          type: "test",
          id: resource_id,
          attributes: resource_attributes,
        })
      end
    end

    context "when relationships are not included" do
      let(:include_relationships) { false }

      it do
        expect(item).to eq({
          type: "test_panels",
          id: resource_id,
          attributes: resource_attributes,
        })

        expect(item).to_not have_key(:relationships)
      end
    end

    context "when attributes are not included" do
      let(:include_attributes) { false }

      it do
        expect(item).to eq({
          type: "test_panels",
          id: resource_id,
          relationships: {
            test: {
              data: [
                { type: "test", id: "LFT" },
                { type: "test", id: "VITD" },
                { type: "test", id: "CHO" }
              ]
            }
          }
        })

        expect(item).to_not have_key(:attributes)
      end
    end
  end
end
