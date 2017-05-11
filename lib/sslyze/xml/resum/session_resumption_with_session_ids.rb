require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class Resum < Plugin
      #
      # Represents the `<sessionResumptionWithSessionIDs/>` XML element.
      #
      # @since 1.0.0
      #
      class SessionResumptionWithSessionIDs

        include Types

        def initialize(node)
          @node = node
        end

        #
        # Number of failed attempts.
        #
        # @return [Integer]
        #
        def failed_attempts
          @failed_attempts ||= @node['failedAttempts'].to_i
        end

        #
        # Determines if Session Resumption with Session IDs is supported.
        #
        # @return [Boolean]
        #
        def is_supported?
          Boolean[@node['isSupported']]
        end

        alias supported? is_supported?

        #
        # Number of successful attempts.
        #
        # @return [Integer]
        #
        def successful_attempts
          @successful_attempts ||= @node['successfulAttempts'].to_i
        end

        #
        # Number of total attempts.
        #
        # @return [Integer]
        #
        def total_attempts
          @total_attempts ||= @node['totalAttempts'].to_i
        end

        #
        # The number of errors that occurred.
        #
        # @return [Integer]
        #
        def error_count
          @error_count ||= @node['errors'].to_i
        end

        #
        # Enumerates over each error message.
        #
        # @yield [error]
        #
        # @yieldparam [String] error
        #
        # @return [Enumerator]
        #   An enumerator will be returned if no block was given.
        #
        def each_error
          return enum_for(__method__) unless block_given?

          @node.search('error').each do |error|
            yield error.inner_text
          end
        end

        #
        # All error messages.
        #
        # @return [Array<String>]
        #
        def errors
          each_error.to_a
        end

      end
    end
  end
end
