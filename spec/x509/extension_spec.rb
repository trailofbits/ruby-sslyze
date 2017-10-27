require 'spec_helper'
require 'openssl'

require 'sslyze/x509/extension'

describe SSLyze::X509::Extension do
  let(:oid) { 'basicConstraints' }
  let(:value) { 'CA:FALSE' }
  let(:critical) { true }

  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new(oid,value,critical)
  end

  subject { described_class.new(openssl_x509_extension) }

  describe "#critical?" do
    it "should return the underlying #critical? value" do
      expect(subject.critical?).to be == openssl_x509_extension.critical?
    end
  end

  describe "#oid" do
    it "should return the underlying #oid value" do
      expect(subject.oid).to be == openssl_x509_extension.oid
    end
  end

  describe "#value" do
    it "should return the underlying #value value" do
      expect(subject.value).to be == openssl_x509_extension.value
    end
  end

  describe "#to_a" do
    it "should return the underlying #to_a value" do
      expect(subject.to_a).to be == openssl_x509_extension.to_a
    end
  end

  describe "#to_der" do
    it "should return the underlying #to_der value" do
      expect(subject.to_der).to be == openssl_x509_extension.to_der
    end
  end

  describe "#to_h" do
    it "should return the underlying #to_h value" do
      expect(subject.to_h).to be == openssl_x509_extension.to_h
    end
  end

  describe "#to_s" do
    it "should return the underlying #to_s value" do
      expect(subject.to_s).to be == openssl_x509_extension.to_s
    end
  end
end
