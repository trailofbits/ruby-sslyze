require 'sslyze/xml/plugin'
require 'sslyze/xml/reneg/session_renegotiation'

module SSLyze
  class XML
    #
    # Represents the `<reneg>` element.
    #
    # @since 1.0.0
    #
    class Reneg < Plugin

      #
      # Session Renegotiation information.
      #
      # @return [SessionRenegotiation, nil]
      #
      # @raise [PluginException]
      #
      def session_renegotiation
        @session_renegotiation ||= exception! do
          if (element = @node.at_xpath('sessionRenegotiation'))
            SessionRenegotiation.new(element)
          end
        end
      end

      alias session session_renegotiation

    end
  end
end
