require 'sslyze/xml/plugin'
require 'sslyze/xml/resum/session_resumption_with_session_ids'

module SSLyze
  class XML
    #
    # Represents the `<resum_rate/>` XML element.
    #
    # @since 1.0.0
    #
    class ResumRate < Plugin

      SessionResumptionWithSessionIDs = Resum::SessionResumptionWithSessionIDs

      #
      # Parses the `<sessionResumptionWithSessionIDs/>` XML element.
      #
      # @return [SessionResumptionWithSessionIDs, nil]
      #
      def session_resumption_with_session_ids
        @session_resumption_with_session_ids ||= if (element = @node.at_xpath('sessionResumptionWithSessionIDs'))
                                                   SessionResumptionWithSessionIDs.new(element)
                                                 end
      end

      alias with_session_ids session_resumption_with_session_ids

    end
  end
end
