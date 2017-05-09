require 'sslyze/target'
require 'sslyze/invalid_target'
require 'sslyze/types'
require 'nokogiri'

module SSLyze
  #
  # Represents the XML output from sslyze.
  #
  class XML

    include Types

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
      @version ||= @doc.at('/document/@SSLyzeVersion').value
    end

    #
    # The default timeout used.
    #
    # @return [Integer]
    #
    # @since 1.0.0
    #
    def network_timeout
      @default_time ||= @doc.at('/document/results/@networkTimeout').value.to_i
    end

    #
    # Whether an HTTPS tunnel was used.
    #
    # @return [Boolean]
    #
    def https_tunnel
      @https_tunnel ||= Boolean[@doc.at('/document/results/@httpsTunnel').value]
    end

    #
    # Specifies whether STARTTLS was enabled.
    #
    # @return [Boolean]
    #
    def start_tls
      @start_tls ||= Boolean[@doc.at('/document/results/@startTLS').value]
    end

    #
    # Duration of the scan.
    #
    # @return [Float]
    #
    def total_scan_time
      @start_tls ||= @doc.at('/document/results/@totalScanTime').value.to_f
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

      @doc.search('invalidTargets/invalidTarget').each do |inval|
        yield InvalidTarget.new(inval)
      end
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

      @doc.search('/document/results/target').each do |target|
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
