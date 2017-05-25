require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/resum/session_resumption_with_session_ids'

describe SSLyze::XML::Resum::SessionResumptionWithSessionIDs do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/resum/sessionResumptionWithSessionIDs' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#failed_attempts" do
    it "should return the failedAttempts attribute" do
      expect(subject.failed_attempts).to be 5
    end
  end

  describe "#is_supported?" do
    it "should parse the isSupported attribute" do
      expect(subject.is_supported?).to be(true).or(be(false))
    end
  end

  describe "#successful_attempts" do
    it "should return the successfulAttempts attribute" do
      expect(subject.successful_attempts).to be 0
    end
  end

  describe "#total_attempts" do
    it "should return the totalAttempts attribute" do
      expect(subject.total_attempts).to be 5
    end
  end

  describe "#error_count" do
    it "should return the errors attribute" do
      expect(subject.error_count).to be 0
    end
  end

  describe "#each_error" do
    context "when a block is given" do
      context "and there are 'error' child XML elements" do
        subject do
          described_class.new(xml.at("#{xpath}[./error]"))
        end
        
        it "should yield the successive error messages" do
          pending "need an example with 'error' XML elements"

          expect { |b|
            subject.each_error(&b)
          }.to yield_successive_args("timeout - timed out")
        end
      end

      context "but there are no 'error' child XML elements" do
        subject do
          described_class.new(xml.at("#{xpath}[not(./error)]"))
        end

        it do
          expect { |b|
            subject.each_error(&b)
          }.to_not yield_control
        end
      end
    end

    context "when no block is given" do
      it "should return an Enumerator" do
        expect(subject.each_error).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#errors" do
    context "when there are 'error' child XML elements" do
      subject do
        described_class.new(xml.at("#{xpath}[./error]"))
      end

      it "should return the error messages" do
        pending "need an example with 'error' XML elements"

        expect(subject.errors).to be == ["timeout - timed out"]
      end
    end

    context "when there are no 'error' child XML elements" do
      subject do
        described_class.new(xml.at("#{xpath}[not(./error)]"))
      end

      it do
        expect(subject.errors).to be == []
      end
    end
  end
end
