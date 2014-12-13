module SSLyze
  class KeyExchange

    def initialize(node)
      @node = node
    end

    def a
      @a ||= @node['A']
    end

    def b
      @b ||= @node['B']
    end

    def cofactor
      @cofactor ||= @node['Cofactor'].to_i
    end

    def field_type
      @field_type ||= @node['Field_Type']
    end

    def generator
      @generator ||= @node['Generator']
    end

    def generator_type
      @generator ||= @node['Generator_Type']
    end

    def group_size
      @group_size ||= @node['GroupSize'].to_i
    end

    def prime
      @prime ||= @node['Prime']
    end

    def seed
      @seed ||= @node['Seed']
    end

    def type
      @type ||= @node['Type']
    end

  end
end
