RSpec.describe DarujmeCz::Connection do
  subject { described_class.new app_id: "22", api_key: "8d948b1" }

  describe ".get" do
    it "get all" do
      stub_request(:get, "https://www.darujme.cz/api/v1/organization/22/pledges-by-filter?apiId=22&apiSecret=8d948b1").
        to_return(status: 200, body: file_fixture("pledges.json"))
      data = subject.get "organization/22/pledges-by-filter"
      expect(data).to include "pledges"
    end
  end

end