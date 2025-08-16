require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api_users" do
    context "some users exists" do
      before do
        10.times do
          FactoryBot.create(:user)
        end
      end

      context "when headers contains Api-Key" do
        let(:headers) { { "Api-Key": "dummy-api-key" } }

        it "responses success" do
          get api_users_path, headers: headers

          expect(response).to have_http_status(:success)
        end
        
        it "returns 5 users" do
          get api_users_path, headers: headers
          json = JSON.parse(response.body)
          
          expect(json.size).to eq(5)
        end
      end

      context "when headers not contains Api-Key" do
        let(:headers) {}

        it "returns auth failed message" do
          get api_users_path, headers: headers
          json = JSON.parse(response.body)

          expect(json["status"]).to eq("auth failed")
        end
      end
    end
  end
end

