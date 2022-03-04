RSpec.describe DarujmeCz::Project do
  let(:attributes) { JSON.parse(file_fixture("project.json").read) }

  subject { described_class.new attributes }

  shared_examples "localized attributes" do |attribute_name, json_source = nil|
    describe "##{attribute_name}" do
      it { expect(subject.send(attribute_name)).to eq attributes[json_source || attribute_name]["cs"] }
      it { expect(subject.send(attribute_name, "pl")).to eq attributes[json_source || attribute_name]["cs"] }
      it { expect(subject.send(attribute_name, "en")).to eq attributes[json_source || attribute_name]["en"] }
    end
  end

  it_behaves_like "localized attributes", "name", "title"
  it_behaves_like "localized attributes", "content"
  it_behaves_like "localized attributes", "synopsis"
end
