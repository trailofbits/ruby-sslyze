require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      class X509v3BasicConstraints < Extension

        def critical?
          @node.inner_text.include?('critical')
        end

        def ca?
          @ca ||= if (match = @node.inner_text.match(/CA:(\w+)/))
                    match[1] == 'TRUE'
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
