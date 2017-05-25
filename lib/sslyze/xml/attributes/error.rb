module SSLyze
  class XML
    module Attributes
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
