require 'rspec'
require 'sslyze/xml'

shared_examples_for "XML specs" do
  let(:path) { File.expand_path('spec/sslyze.xml') }
  let(:xml)  { Nokogiri::XML(open(path)) }

  subject { SSLyze::XML.new(xml) }
end
