require 'sslyze/xml/plugin'
require 'sslyze/xml/resum/session_resumption_with_session_ids'
require 'sslyze/xml/resum/session_resumption_with_tls_tickets'

module SSLyze
  class XML
    #
    # Represents the `<resum>` XML element.
    #
    # @since 1.0.0
    #
    class Resum < Plugin

      #
      # Parses the `<sessionResumptionWithSessionIDs>` XML element.
      #
      # @return [SessionResumptionWithSessionIDs, nil]
      #
      def session_resumption_with_session_ids
        @session_resumption_with_session_ids ||= if (element = @node.at_xpath('sessionResumptionWithSessionIDs'))
                                                   SessionResumptionWithSessionIDs.new(element)
                                                 end
      end

      alias with_session_ids session_resumption_with_session_ids

      #
      # Parses the `<sessionResumptionWithTLSTickets>` XML element.
      #
      # @return [SessionResumptionWithTLSTickets, nil]
      #
      def session_resumption_with_tls_tickets
        @session_resumption_with_tls_tickets ||= if (element = @node.at_xpath('sessionResumptionWithTLSTickets'))
                                                   SessionResumptionWithTLSTickets.new(element)
                                                 end
      end

      alias with_tls_tickets session_resumption_with_tls_tickets

    end
  end
end
