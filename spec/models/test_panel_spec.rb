require 'rails_helper'

describe TestPanel, type: :model do
  it 'should store the data in a DATA constant' do
    expect(TestPanel::DATA.length > 0).to eq true
  end

  describe ".find" do
    subject(:find_result) { described_class.find(test_panel_id) }
    context "with an existing ID" do
      let(:test_panel_id) { "TP1" }

      it "returns a test panel with the specified ID" do
        expect(find_result).to be_instance_of(described_class)

        expect(find_result).to have_attributes(
          id: test_panel_id,
          test_ids: %w[CHO VITD],
          price: 1700,
        )
      end
    end

    context "with a non-existent ID" do
      let(:test_panel_id) { "foobar" }

      it { is_expected.to be_nil }
    end
  end

  describe "#tests" do
    let(:model) { described_class.find("TP1") }

    it "returns all tests for the Test Panel" do
      expect(model.tests).to all(be_a Test)
    end

    it do
      expect(model.tests).
        to match_array([have_attributes(id: "CHO"), have_attributes(id: "VITD")])
    end
  end

  describe "#sample_tube_types" do
    let(:model) { described_class.find("TP2") }

    it do
      expect(model.sample_tube_types).to eq([:purple, :yellow])
    end
  end

  describe "#sample_volume_requirement" do
    let(:model) { described_class.find("TP3") }

    it do
      expect(model.sample_volume_requirement).to eq(280)
    end
  end
end
