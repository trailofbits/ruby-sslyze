require 'sslyze/x509/extension'

module SSLyze
  module X509
    module Extensions
      #
      # Represents the `basicConstraints` X509v3 extension.
      #
      # @since 1.0.0
      #
      class BasicConstraints < Extension

        #
        # The value of the `CA` constraint.
        #
        # @return [Boolean, nil]
        #
        def ca?
          if    value.include?('CA:TRUE') then true
          elsif value.include?('CA:FALSE') then false
          end
        end

        #
        # The value of the `pathlen` constraint.
        #
        # @return [Integer, nil]
        #
        def path_length
          @path_length ||= if (match = value.match(/pathlen:(\d+)/))
                             match[1].to_i
                           end
        end

        alias path_len path_length
        alias pathlen path_length

      end
    end
  end
end
