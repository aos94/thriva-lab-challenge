require "rails_helper"

describe ResourceSerializers::TestPanelSerializer do
  let(:serializer) { described_class.new(test_panel) }

  let(:test_panel) { TestPanel.find(test_panel_id) }
  let(:test_panel_id) { "TP3" }
  let(:serialized_test_panel_attributes) do
    {
      price: 1800,
      sample_tube_types: [:yellow, :yellow, :yellow],
      sample_volume_requirement: 280,
    }
  end

  describe "#attributes" do
    it do
      expect(serializer.attributes).to eq(serialized_test_panel_attributes)
    end
  end

  describe "#serialize" do
    subject { serializer.serialize(include_attributes: include_attributes) }
    let(:include_attributes) { true }

    context "when attributes are included" do
      it do
        expect(subject[:type]).to eq(described_class::RESOURCE_TYPE)
        expect(subject[:id]).to eq("TP3")
        expect(subject[:attributes]).to eq(serialized_test_panel_attributes)
      end
    end

    context "when attributes are excluded" do
      let(:include_attributes) { false }

      it do
        expect(subject[:type]).to eq(described_class::RESOURCE_TYPE)
        expect(subject[:id]).to eq(test_panel_id)
        expect(subject).to_not have_key(:attributes)
      end
    end
  end
end
