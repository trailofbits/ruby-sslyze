require 'rspec'

shared_examples_for "Plugin element" do
  describe "#title" do
    it "should parse the title attribute" do
      expect(subject.title).to be_kind_of(String)
      expect(subject.title).not_to be_empty
    end
  end

  describe "#exception" do
    pending "need an examples of plugin elements with exception messages"
  end
end
