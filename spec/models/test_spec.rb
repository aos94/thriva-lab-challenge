require 'rails_helper'

describe Test, type: :model do
  it 'should store the data in a DATA constant' do
    expect(Test::DATA.length > 0).to eq true
  end

  describe ".find" do
    subject(:find_result) { described_class.find(test_id) }
    context "with an existing ID" do
      let(:test_id) { "HBA1C" }

      it "returns a test with the specified ID" do
        expect(find_result).to be_instance_of(described_class)

        expect(find_result).to have_attributes(
          id: test_id,
          name: "HbA1C",
          sample_volume_requirement: 40,
          sample_tube_type: :purple,
        )
      end
    end

    context "with a non-existent ID" do
      let(:test_id) { "foobar" }

      it { is_expected.to be_nil }
    end
  end
end
