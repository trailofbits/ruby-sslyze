require 'rspec'
require 'sslyze/xml'

shared_examples_for "XML specs" do
  let(:path) { File.expand_path('spec/sslyze.xml') }
  let(:xml)  { Nokogiri::XML(open(path)) }

  let(:xpath) { '/' }
  let(:node)  { xml.at_xpath(xpath) }

  subject { described_class.new(node) }
end
