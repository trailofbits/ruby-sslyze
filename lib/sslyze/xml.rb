require 'sslyze/xml/target'
require 'sslyze/xml/invalid_target'
require 'sslyze/xml/types'
require 'sslyze/xml/attributes/title'

require 'nokogiri'

module SSLyze
  #
  # Represents the XML output from sslyze.
  #
  # @see https://github.com/nabla-c0d3/sslyze/blob/master/xml_out.xsd
  #
  class XML

    include Types
    include Attributes::Title

    #
    # Initializes the XML.
    #
    # @param [Nokogiri::XML::Document] doc
    #   The XML document.
    #
    def initialize(doc)
      @doc = doc
    end

    #
    # Parses the XML.
    #
    # @param [String] xml
    #   The raw XML.
    #
    # @return [XML]
    #
    def self.parse(xml)
      new(Nokogiri::XML.parse(xml))
    end

    #
    # Opens the XML file.
    #
    # @param [String] path
    #   Path to the XML file.
    #
    # @return [XML]
    #
    def self.open(path)
      new(File.open(path) { |file| Nokogiri::XML(file) })
    end

    #
    # The version of the XML output.
    #
    # @return [String]
    #
    def version
      @version ||= @doc.at_xpath('/document/@SSLyzeVersion').value
    end

    #
    # The default timeout used.
    #
    # @return [Integer, nil]
    #
    # @since 1.0.0
    #
    def network_timeout
      @default_time ||= if (attr = @doc.at_xpath('/document/results/@networkTimeout'))
                          attr.value.to_i
                        end
    end

    #
    # Duration of the scan.
    #
    # @return [Float]
    #
    def total_scan_time
      @total_scan_time ||= @doc.at_xpath('/document/results/@totalScanTime').value.to_f
    end

    # Enumerates over each invalid target.
    #
    # @yield [invalidtarget]
    #
    # @yieldparam [InvalidTarget] invalid_target
    #
    # @return [Enumerator]
    #
    # @since 0.2.0
    #
    def each_invalid_target
      return enum_for(__method__) unless block_given?

      @doc.xpath('/document/invalidTargets/invalidTarget').each do |inval|
        yield InvalidTarget.new(inval)
      end
    end

    #
    # @return [Array<InvalidTarget>]
    #
    # @see #each_invalid_target
    #
    # @since 0.2.0
    #
    def invalid_targets
      each_invalid_target.to_a
    end

    #
    # Enumerates over each target.
    #
    # @yield [target]
    #
    # @yieldparam [Target] target
    #
    # @return [Enumerator]
    #
    def each_target
      return enum_for(__method__) unless block_given?

      @doc.xpath('/document/results/target').each do |target|
        yield Target.new(target)
      end
    end

    alias each each_target

    #
    # @return [Array<Target>]
    #
    # @see #each_target
    #
    def targets
      each_target.to_a
    end

    #
    # The first target.
    #
    # @return [Target, nil]
    #
    def target
      each_target.first
    end

  end
end
