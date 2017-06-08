require 'spec_helper'
require 'sslyze/x509/extensions/subject_alt_name'

describe SSLyze::X509::Extensions::SubjectAltName do
  let(:domains) do
    %w[
      example.com
      foo.example.com
      bar.example.com
    ]
  end
  let(:dns_names) do
    domains.map { |name| "DNS:#{name}" }
  end

  let(:ips) do
    %w[
      127.0.0.1
      10.0.0.1
    ]
  end
  let(:ip_names) do
    ips.map { |name| "IP:#{name}" }
  end

  let(:uris) do
    %w[
      https://foo.com/
      https://bar.com/
    ]
  end
  let(:uri_names) do
    uris.map { |name| "URI:#{name}" }
  end

  let(:email_addresses) do
    %w[
      foo@example.com
      bar@example.com
    ]
  end
  let(:email_names) do
    email_addresses.map { |name| "email:#{name}" }
  end

  let(:names) { dns_names + ip_names + uri_names + email_names }
  let(:value) { names.join(', ') }

  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new('subjectAltName', value)
  end

  subject { described_class.new(openssl_x509_extension) }

  describe "#each" do
    context "when a block is given" do
      context "when value contains 'DNS:' names" do
        let(:names) { dns_names }

        it "should yield (:dns, name) tuples" do
          expect { |b|
            subject.each(&b)
          }.to yield_successive_args(*domains.map { |domain| [:dns, domain] })
        end
      end

      context "when value contains 'IP:' names" do
        let(:names) { ip_names }

        it "should yield (:ip, name) tuples" do
          expect { |b|
            subject.each(&b)
          }.to yield_successive_args(*ips.map { |ip| [:ip, ip] })
        end
      end

      context "when value contains 'URI:' names" do
        let(:names) { uri_names }

        it "should yield (:uri, name) tuples" do
          expect { |b|
            subject.each(&b)
          }.to yield_successive_args(*uris.map { |uri| [:uri, uri] })
        end
      end

      context "when value contains 'email:' names" do
        let(:names) { email_names }

        it "should yield (:email, name) tuples" do
          expect { |b|
            subject.each(&b)
          }.to yield_successive_args(*email_addresses.map { |email| [:email, email] })
        end
      end

      context "when value contains 'RID:' names"
      context "when value contains 'dirName:' names"
      context "when value contains 'otherName:' names"
    end

    context "when no block is given" do
      it "should return return an Enumerator" do
        expect(subject.each).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#dns" do
    it "should return only the 'DNS:' names" do
      expect(subject.dns).to be == domains
    end
  end

  describe "#ip" do
    it "should return only the 'IP:' names" do
      expect(subject.ip.map(&:to_s)).to be == ips
    end

    it "should parse each 'IP:' name as an IPAddr" do
      expect(subject.ip).to all(be_kind_of(IPAddr))
    end
  end

  describe "#uri" do
    it "should return only the 'URI:' names" do
      expect(subject.uri.map(&:to_s)).to be == uris
    end

    it "should parse each 'URI:' name as an URI" do
      expect(subject.uri).to all(be_kind_of(URI::Generic))
    end
  end

  describe "#email" do
    it "should return only the 'email:' names" do
      expect(subject.email).to be == email_addresses
    end
  end

  describe "#rid"
  describe "#dir_name"
  describe "#other_name"
end
