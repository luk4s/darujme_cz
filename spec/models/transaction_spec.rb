RSpec.describe DarujmeCz::Transaction do
  describe ".all" do
    it "get all" do
      stub_request(:get, "https://www.darujme.cz/api/v1/organization/#{DarujmeCz.config.organization_id}/transactions-by-filter?apiId=#{DarujmeCz.config.app_id}&apiSecret=#{DarujmeCz.config.app_secret}")
        .to_return(status: 200, body: file_fixture("transactions.json"))

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

  describe "#sent_amount" do
    context "with amount" do
      it { expect(subject.sent_amount).to be_a Money }
    end
    context "without amount" do
      subject { described_class.new json["transactions"][1] }
      it { expect(subject.sent_amount).to be_nil }
    end
  end

  describe "#outgoing_amount" do
    context "with amount" do
      it { expect(subject.outgoing_amount).to be_a Money }
    end
    context "without amount" do
      subject { described_class.new json["transactions"][1] }
      it { expect(subject.outgoing_amount).to be_nil }
    end
  end

  describe "#received_at" do
    it { expect(subject.received_at).to be_a Time }
    context "null" do
      subject { described_class.new json["transactions"][1] }
      it { expect(subject.received_at).to be_nil }
    end
  end

  describe "#status" do
    it { expect(subject.status).to eq "refund" }
    it { expect(subject.refund?).to eq true }
    it { expect(subject.pending?).to eq false }
  end
end
