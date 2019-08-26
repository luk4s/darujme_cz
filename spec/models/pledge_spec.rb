require "rest-client"
RSpec.describe DarujmeCz::Pledge do
  describe ".all" do
    it "get all" do
      stub_request(:get, "https://www.darujme.cz/api/v1/organization/#{DarujmeCz.config.organization_id}/pledges-by-filter?apiId=#{DarujmeCz.config.app_id}&apiSecret=#{DarujmeCz.config.app_secret}").
        to_return(status: 200, body: file_fixture("pledges.json"))

      pledges = described_class.all
      expect(pledges).to be_a Array
      expect(pledges[0]).to have_attributes "organization_id" => 2
    end

    it "without organization_id" do
      DarujmeCz.config.organization_id = nil
      expect { described_class.all }.to raise_exception ArgumentError
    end

    it "without credentials" do
      DarujmeCz.config.app_id = nil

      stub_request(:get, "https://www.darujme.cz/api/v1/organization/#{DarujmeCz.config.organization_id}/pledges-by-filter?apiId&apiSecret=#{DarujmeCz.config.app_secret}").
        to_return(status: 400, body: darujme_cz_response_error(message: "Missing required parameter").to_json)

      expect { described_class.all }.to raise_exception RestClient::BadRequest, "400 Bad Request\nMissing required parameter"
    end

    it "pass custom organization_id" do
      stub = stub_request(:get, "https://www.darujme.cz/api/v1/organization/33/pledges-by-filter?apiId=#{DarujmeCz.config.app_id}&apiSecret=#{DarujmeCz.config.app_secret}").
        to_return(status: 200, body: file_fixture("pledges.json"))

      described_class.all(organization_id: 33)
      expect(stub).to have_been_made
    end
  end

  describe ".where" do
    it "fromOutgoingDate" do
      stub = stub_request(:get, "https://www.darujme.cz/api/v1/organization/#{DarujmeCz.config.organization_id}/pledges-by-filter?apiId=#{DarujmeCz.config.app_id}&apiSecret=#{DarujmeCz.config.app_secret}&fromOutgoingDate=#{Date.today.strftime("%Y-%m-%d")}").
        to_return(status: 200, body: file_fixture("pledges.json"))
      described_class.where fromOutgoingDate: Date.today

      expect(stub).to have_been_made
    end
  end

  let(:json) { JSON.parse file_fixture("pledges.json").read }
  subject { described_class.new json["pledges"][0] }

  describe "attributes" do

    it "inspect" do
      expect(subject.project_id).to eq 4563
      expect(subject.id).to eq 1203450
    end
  end

  describe "#amount" do
    it { expect(subject.amount.to_f).to eq 1358.0 }
    it { expect(subject.amount.currency).to eq "CZK" }
  end

  describe "#pledged_at" do
    it { expect(subject.pledged_at).to be_a Time }
  end

  describe "#recurrent?" do
    it { expect(subject.recurrent?).to eq true }
  end

  describe "#want_donation_certificate?" do
    it { expect(subject.want_donation_certificate?).to eq true }
  end

  describe "#donor" do
    it { expect(subject.donor).to be_a DarujmeCz::Donor }
  end

  describe "#transactions" do
    it "be a array" do
      expect(subject.transactions).to be_a Array
      expect(subject.transactions[0]).to be_a DarujmeCz::Transaction
    end
  end

  it "#name" do
    expect(subject.name).to eq "Jan Novák"
  end

  it "#city" do
    expect(subject.city).to eq "Praha"
  end

  describe "#project" do
    before :each do
      stub_request(:get, "https://www.darujme.cz/api/v1/project/4563?apiId=123&apiSecret=abcd").
        to_return(status: 200, body: { project: JSON.parse(file_fixture("project.json").read) }.to_json)
    end
    it { expect(subject.project).to be_a DarujmeCz::Project }
  end

end
