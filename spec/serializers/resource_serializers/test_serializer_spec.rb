require "rails_helper"

describe ResourceSerializers::TestSerializer do
  let(:serializer) { described_class.new(test) }

  let(:test) { Test.new(**sample_test_data) }
  let(:sample_test_data) do
    {
      id: "FOO",
      name: "Foo Blood Test",
      sample_volume_requirement: 195,
      sample_tube_type: :turquoise,
    }
  end

  let(:test_id) { "FOO" }

  let(:serialized_test_attributes) do
    {
      name: "Foo Blood Test",
      sample_tube_type: :turquoise,
      sample_volume_requirement: 195,
    }
  end

  describe "#attributes" do
    it do
      expect(serializer.attributes).to eq(serialized_test_attributes)
    end
  end

  describe "#serialize" do
    subject { serializer.serialize(include_attributes: include_attributes) }
    let(:include_attributes) { true }

    context "when attributes are included" do
      it do
        expect(subject[:type]).to eq(described_class::RESOURCE_TYPE)
        expect(subject[:id]).to eq(test_id)
        expect(subject[:attributes]).to eq(serialized_test_attributes)
      end
    end

    context "when attributes are excluded" do
      let(:include_attributes) { false }

      it do
        expect(subject[:type]).to eq(described_class::RESOURCE_TYPE)
        expect(subject[:id]).to eq(test_id)
        expect(subject).to_not have_key(:attributes)
      end
    end
  end
end
