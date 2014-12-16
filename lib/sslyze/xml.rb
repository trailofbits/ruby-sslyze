require 'sslyze/target'
require 'sslyze/types'
require 'nokogiri'

module SSLyze
  #
  # Represents the XML output from sslyze.
  #
  class XML

    include Types

    def initialize(doc)
      @doc = doc
    end

    def self.parse(xml)
      new(Nokogiri::XML.parse(xml))
    end

    def self.open(path)
      new(Nokogiri::XML(File.open(path)))
    end

    def version
      @version ||= @doc.at('/document/@SSLyzeVersion').value.split(' ',2).last
    end

    def default_timeout
      @default_time ||= @doc.at('/document/results/@defaultTimeout').value.to_i
    end

    def https_tunnel
      @https_tunnel ||= Boolean[@doc.at('/document/results/@httpsTunnel').value]
    end

    def start_tls
      @start_tls ||= Boolean[@doc.at('/document/results/@startTLS').value]
    end

    def total_scan_time
      @start_tls ||= @doc.at('/document/results/@totalScanTime').value.to_f
    end

    def invalid_targets
      # TODO
    end

    def each_target
      return enum_for(__method__) unless block_given?

      @doc.search('/document/results/target').each do |target|
        yield Target.new(target)
      end
    end

    alias each each_target

    def targets
      each_target.to_a
    end

    def target
      each_target.first
    end

  end
end
