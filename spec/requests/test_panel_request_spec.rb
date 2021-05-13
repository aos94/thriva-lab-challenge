require "rails_helper"

describe "Requesting a test panel", type: :request do
  context "with a non-existent test panel ID" do
    let(:test_panel_id) { "TP-non-existent" }

    before { get "/test_panels/#{test_panel_id}" }

    it "responds with a not found error" do
      expect(response).to have_http_status(404)

      fixture = load_json_fixture("requests/test_panels/show_not_found")

      expect(response.content_type).to eq(Mime[:json].to_s)

      response_json = JSON.parse(response.body)
      expect(response_json).to eq(fixture)
    end
  end

  context "with a valid test panel ID" do
    let(:test_panel_id) { "TP2" }

    before { get "/test_panels/#{test_panel_id}" }

    it "responds with an HTTP 200 status" do
      expect(response).to have_http_status(200)
    end

    it "responds with details about the test panel" do
      fixture = load_json_fixture("requests/test_panels/show")

      expect(response.content_type).to eq(Mime[:json].to_s)

      response_json = JSON.parse(response.body)
      expect(response_json).to eq(fixture)
    end

    context "when includes are requested" do
      before { get "/test_panels/#{test_panel_id}?include=test" }

      it "responds with the requested includes" do
        fixture = load_json_fixture("requests/test_panels/show_with_includes")

        expect(response.content_type).to eq(Mime[:json].to_s)

        response_json = JSON.parse(response.body)
        expect(response_json).to eq(fixture)
      end

      context "with invalid include parameters" do
        before { get "/test_panels/#{test_panel_id}?include=test,nonsense" }

        it "returns an error response" do
          fixture = load_json_fixture("requests/test_panels/show_with_invalid_includes")

          expect(response.content_type).to eq(Mime[:json].to_s)
          expect(response).to have_http_status(400)

          response_json = JSON.parse(response.body)
          expect(response_json).to eq(fixture)
        end
      end
    end
  end
end
