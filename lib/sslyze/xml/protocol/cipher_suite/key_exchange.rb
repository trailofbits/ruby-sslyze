module SSLyze
  class XML
    class Protocol
      class CipherSuite
        #
        # Key exchange information.
        #
        class KeyExchange

          #
          # Initializes the key exchange information.
          #
          # @param [Nokogiri::XML::Node] node
          #   The `<keyExchange>` information.
          #
          def initialize(node)
            @node = node
          end

          #
          # @return [String, nil]
          #
          def a
            @a ||= @node['A']
          end

          #
          # @return [String, nil]
          #
          def b
            @b ||= @node['B']
          end

          #
          # @return [Integer, nil]
          #
          def cofactor
            @cofactor ||= if (value = @node['Cofactor'])
                            value.to_i
                          end
          end

          #
          # @return [String, nil]
          #
          def field_type
            @field_type ||= @node['Field_Type']
          end

          #
          # @return [String]
          #
          def generator
            @generator ||= @node['Generator']
          end

          #
          # @return [Symbol, nil]
          #
          def generator_type
            @generator_type ||= if (value = @node['GeneratorType'])
                                  value.to_sym
                                end
          end

          #
          # @return [Integer]
          #
          def group_size
            @group_size ||= @node['GroupSize'].to_i
          end

          #
          # @return [String, nil]
          #
          # @since 1.0.0
          #
          def order
            @order ||= @node['Order']
          end

          #
          # @return [String, nil]
          #
          def prime
            @prime ||= @node['Prime']
          end

          #
          # @return [String, nil]
          #
          def seed
            @seed ||= @node['Seed']
          end

          #
          # @return [Symbol]
          #
          def type
            @type ||= @node['Type'].to_sym
          end

          #
          # Determines if DH key exchange was used.
          #
          # @return [Boolean]
          #
          def dh?
            type == :DH
          end

          #
          # Determines if ECDHE key exchange was used.
          #
          # @return [Boolean]
          #
          def ecdhe?
            type == :ECDHE
          end

        end
      end
    end
  end
end
