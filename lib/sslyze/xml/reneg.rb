require 'sslyze/xml/plugin'
require 'sslyze/xml/reneg/session_renegotiation'

module SSLyze
  class XML
    #
    # Represents the `<reneg/>` element.
    #
    # @since 1.0.0
    #
    class Reneg < Plugin

      #
      # Parses the `sessionRenegotiation` element.
      #
      # @return [SessionRenegotiation, nil]
      #
      def session_renegotiation
        @session_renegotiation ||= if (element = @node.at_xpath('sessionRenegotiation'))
                                     SessionRenegotiation.new(element)
                                   end
      end

      alias session session_renegotiation

    end
  end
end
