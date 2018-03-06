module SSLyze
  class XML
    module Attributes
      #
      # Provides methods for parsing the `error` XML attribute.
      #
      # @since 1.0.0
      #
      module Error
        #
        # The error message, if an error occurred.
        #
        # @return [String, nil]
        #
        def error
          @error ||= @node['error']
        end

        #
        # Determines if an error occurred.
        #
        # @return [Boolean]
        #
        def error?
          !error.nil?
        end
      end
    end
  end
end
