module SSLyze
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
    # @return [String]
    #
    def a
      @a ||= @node['A']
    end

    #
    # @return [String]
    #
    def b
      @b ||= @node['B']
    end

    #
    # @return [Integer]
    #
    def cofactor
      @cofactor ||= @node['Cofactor'].to_i
    end

    #
    # @return [String]
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
    # @return [Symbol]
    #
    def generator_type
      @generator ||= @node['GeneratorType'].to_sym
    end

    #
    # @return [Integer]
    #
    def group_size
      @group_size ||= @node['GroupSize'].to_i
    end

    #
    # @return [String]
    #
    def prime
      @prime ||= @node['Prime']
    end

    #
    # @return [String]
    #
    def seed
      @seed ||= @node['Seed']
    end

    #
    # @return [:DH, :ECDHE]
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
