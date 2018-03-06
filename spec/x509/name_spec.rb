require 'rspec'
require 'openssl'

require 'sslyze/x509/name'

describe SSLyze::X509::Name do
  let(:country_name)             { 'US'               }
  let(:state_name)               { 'California'       }
  let(:location_name)            { 'San Francisco'    }
  let(:organization_name)        { 'Twitter, Inc.'    }
  let(:organizational_unit_name) { 'Twitter Security' }
  let(:common_name)              { 'twitter.com'      }

  let(:entries) do
    [
      ["C", country_name, 19],
      ["ST", state_name, 19],
      ["L", location_name, 19],
      ["O", organization_name, 19],
      ["OU", organizational_unit_name, 19],
      ["CN", common_name, 19]
    ]
  end
  let(:openssl_x509_name) { OpenSSL::X509::Name.new(entries) }

  subject { described_class.new(openssl_x509_name) }

  describe "#each" do
    it "should iterate over the entries" do
      expect { |b|
        subject.each(&b)
      }.to yield_successive_args(*entries)
    end
  end

  describe "#[]" do
    it "should return the value for the given OID key" do
      expect(subject['C']).to be == country_name
    end

    context "when the OID key cannot be found" do
      it { expect(subject['foo']).to be nil }
    end
  end

  describe "#country_name" do
    it "should return the 'C' entry" do
      expect(subject.country_name).to be == country_name
    end
  end

  describe "#state_name" do
    it "should return the 'ST' entry" do
      expect(subject.state_name).to be == state_name
    end
  end

  describe "#location_name" do
    it "should return the 'L' entry" do
      expect(subject.location_name).to be == location_name
    end
  end

  describe "#organization_name" do
    it "should return the 'O' entry" do
      expect(subject.organization_name).to be == organization_name
    end
  end

  describe "#organizational_unit_name" do
    it "should return the 'OU' entry" do
      expect(subject.organizational_unit_name).to be == organizational_unit_name
    end
  end

  describe "#common_name" do
    it do
      expect(subject.common_name).to be_kind_of(SSLyze::X509::Domain)
    end

    it "should be equal to the 'CN' entry" do
      expect(subject.common_name.name).to be == common_name
    end
  end
end
