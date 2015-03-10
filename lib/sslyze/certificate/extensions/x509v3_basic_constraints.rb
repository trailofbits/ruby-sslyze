require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      #
      # Represents the `<X509v3BasicConstraints>` XML element.
      #
      class X509v3BasicConstraints < Extension

        #
        # Specifies whether the `critical` constraint was specified.
        #
        # @return [Boolean]
        #
        def critical?
          @node.inner_text.include?('critical')
        end

        #
        # The value of the `CA` constraint.
        #
        # @return [Boolean, nil]
        #
        def ca?
          if    @node.inner_text.include?('CA:TRUE')  then true
          elsif @node.inner_text.include?('CA:FALSE') then false
          end
        end

        #
        # The value of the `pathlen` constraint.
        #
        # @return [Integer, nil]
        #
        def path_length
          @path_length ||= if (match = @node.inner_text.match(/pathlen:(\d+)/))
                             match[1].to_i
                           end
        end

        alias path_len path_length

        #
        # The raw basic constraint String.
        #
        # @return [String]
        #
        def to_s
          if @node then @node.inner_text
          else          ''
          end
        end

        alias to_str to_s

      end
    end
  end
end
