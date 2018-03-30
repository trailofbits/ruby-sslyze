require 'sslyze/xml/plugin'

module SSLyze
  class XML
    class Certinfo < Plugin
      class Certificate
        #
        # @since 1.2.0
        #
        class PublicKey

          ALGORITHMS = {
            'RSA'             => :RSA,
            'DSA'             => :DSA,
            'EllipticCurve' => :EC
          }

          #
          # Initializes the public-key information.
          #
          # @param [Nokogiri::XML::Node]
          #
          def initialize(node)
            @node = node
          end

          #
          # The algorithm used to generate the public-key.
          #
          # @return [:RSA, :DSA, :EC]
          #
          # @raise [NotImplementedError]
          #   Unrecognized algorithm name.
          #
          def algorithm
            unless @algorithm
              name = @node['algorithm']

              @algorithm = ALGORITHMS.fetch(name) do
                raise(notimplementederror,"unknown public-key algorithm: #{name.inspect}")
              end
            end

            return @algorithm
          end

          #
          # The size of the public-key.
          #
          # @return [Integer]
          #   The size in bits.
          #
          def size
            @size ||= @node['size'].to_i
          end

          #
          # The Elliptical Curve that was used.
          #
          # @return [Symbol, nil]
          #   The Elliptical Curve, or `nil` if {#algorithm} was not `:EC`.
          #
          def curve
            @curve ||= if (curve = @node['curve'])
                         curve.to_sym
                       end
          end

          #
          # The exponent used to generate the public-key
          #
          # @return [Integer, nil]
          #
          def exponent
            @exponent ||= if (exponent = @node['exponent'])
                            exponent.to_i
                          end
          end

        end
      end
    end
  end
end
