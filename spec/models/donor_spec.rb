RSpec.describe DarujmeCz::Donor do
  let(:attributes) { JSON.parse(file_fixture("donor.json").read) }

  subject { described_class.new attributes }

  it "#attributes" do
    expect(subject).to have_attributes first_name: "Jan", last_name: "Novák"
  end

  it "#name" do
    expect(subject.name).to eq "Jan Novák"
  end

  describe "#address" do
    it { expect(subject.address).to be_a DarujmeCz::Address }
    it "text address" do
      expect(subject.address.to_s).to eq "Otakarova 34\n120 00 Praha\nČR"
    end

    it "#city" do
      expect(subject.address.city).to eq "Praha"
    end
  end

  it "#street" do
    expect(subject.street).to eq "Otakarova 34"
  end

end
