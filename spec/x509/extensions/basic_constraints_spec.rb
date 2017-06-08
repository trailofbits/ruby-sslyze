require 'spec_helper'
require 'sslyze/x509/extensions/basic_constraints'

describe SSLyze::X509::Extensions::BasicConstraints do
  let(:ca)      { 'TRUE' }
  let(:pathlen) { 1 }
  let(:value)   { "CA:#{ca}, pathlen:#{pathlen}" }
  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new('basicConstraints', value, true)
  end

  subject { described_class.new(openssl_x509_extension) }

  describe "#ca?" do
    context "when 'CA:TRUE' is present" do
      let(:ca) { 'TRUE' }

      it { expect(subject.ca?).to be true }
    end

    context "when 'CA:FALSE' is present" do
      let(:ca) { 'FALSE' }

      it { expect(subject.ca?).to be false }
    end

    context "when 'CA:' is omitted" do
      let(:value) { 'pathlen:0' }

      it { expect(subject.ca?).to be nil }
    end
  end

  describe "#path_length" do
    it "should parse the decimal following 'pathlen:'" do
      expect(subject.path_length).to be == pathlen
    end
  end
end
