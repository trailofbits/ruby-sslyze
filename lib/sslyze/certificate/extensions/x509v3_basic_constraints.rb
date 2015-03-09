require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      class X509v3BasicConstraints < Extension

        def critical?
          @node.inner_text.include?('critical')
        end

        def ca?
          if   @node.inner_text.include?('CA:TRUE') then true
          else @node.inner_text.include?('CA:FALSE') then false
          end
        end

        def path_length
          @path_length ||= if (match = @node.inner_text.match(/pathlen:(\d+)/))
                             match[1].to_i
                           end
        end

        alias path_len path_length

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
