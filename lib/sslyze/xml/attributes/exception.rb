module SSLyze
  class XML
    module Attributes
      #
      # Provides methods for accessing the `exception` XML attribute.
      #
      # @since 1.0.0
      #
      module Exception
        #
        # The exception message, if an exception occurred.
        #
        # @return [String, nil]
        #
        def exception
          @exception ||= @node['exception']
        end

        #
        # Tests whether an exception occurred.
        #
        # @return [Boolean]
        #
        def exception?
          !exception.nil?
        end
      end
    end
  end
end
