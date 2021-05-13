require "rails_helper"

describe ResponseItem do
  let(:instance) { described_class.new(resource: resource, includes: includes) }

  let(:resource) { TestPanel.find(resource_id) }
  let(:resource_id) { "TP2" }
  let(:includes) { [] }

  describe "#call" do
    subject(:response_item) { instance.call }

    it "returns an open-api representation of the supplied resource" do
      expect(response_item).to match({
        data: {
          type: "test_panels",
          id: resource_id,
          attributes: instance_of(Hash),
          relationships: hash_including(
            test: {
              data: [
                { id: instance_of(String), type: "test" },
                { id: instance_of(String), type: "test" },
              ]
            }
          ),
        }
      })
    end

    context "when there are includes specified" do
      let(:includes) { [:test] }
      it do
        expect(response_item).to match({
          data: instance_of(Hash),
          included: [
            hash_including(type: "test"),
            hash_including(type: "test"),
          ]
        })
      end
    end
  end
end
