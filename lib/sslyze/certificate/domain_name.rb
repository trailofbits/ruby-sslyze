module SSLyze
  class Certificate
    #
    # Represents a domain name pattern.
    #
    class DomainName

      # The subject name.
      #
      # @return [String]
      attr_reader :name

      # The domain part of the subject name.
      #
      # @return [String]
      attr_reader :domain

      # The literal suffix of the subject name.
      #
      # @return [String]
      attr_reader :suffix

      #
      # Initializes the subject name.
      #
      # @param [String] name
      #   The subject name.
      #
      def initialize(name)
        @name = name

        if @name.start_with?('*.')
          @suffix = @name[1..-1]
          @domain = @name[2..-1]
        else
          @domain = @name
        end
      end

      #
      # Compares two subject names.
      #
      # @return [Boolean]
      #
      def ==(other)
        @name == other.name
      end

      #
      # Tests whether the domain is matched by the subject name.
      #
      def include?(domain)
        if @name.start_with?('*.') # wildcard
          domain.end_with?(@suffix) || # does the domain share the suffix
            domain == @domain            # does the domain match the suffix
        else # exact match
          domain == @name
        end
      end

      alias === include?

      alias to_s name
      alias to_str name

      #
      # Inspects the subject name.
      #
      # @return [String]
      #
      def inspect
        "#<#{self.class}: #{self}>"
      end

    end
  end
end
