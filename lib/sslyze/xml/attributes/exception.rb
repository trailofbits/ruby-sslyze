module SSLyze
  class XML
    module Attributes
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
