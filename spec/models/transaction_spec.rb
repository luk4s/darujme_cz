RSpec.describe DarujmeCz::Transaction do
  describe ".all" do
    it "get all" do
      stub_request(:get, "https://www.darujme.cz/api/v1/organization/#{DarujmeCz.config.organization_id}/transactions-by-filter?apiId=#{DarujmeCz.config.app_id}&apiSecret=#{DarujmeCz.config.app_secret}").
        to_return(status: 200, body: file_fixture("transactions.json"))

      pledges = described_class.all
      expect(pledges).to be_a Array
      expect(pledges[0]).to have_attributes "outgoing_bank_account" => "12345/0100"
    end
  end

  let(:json) { JSON.parse file_fixture("transactions.json").read }
  subject { described_class.new json["transactions"][0] }

  it "#pledge" do
    expect(subject.pledge).to be_a DarujmeCz::Pledge
  end

  it "#sent_amount" do
    expect(subject.sent_amount).to be_a Money
  end

  it "#outgoing_amount" do
    expect(subject.outgoing_amount).to be_a Money
  end

  it "#received_at" do
    expect(subject.received_at).to be_a Time
  end

end