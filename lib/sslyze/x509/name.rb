require 'openssl'

module SSLyze
  module X509
    #
    # Wrapper object for [OpenSSL::X509::Name][1].
    #
    # [1]: http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name
    #
    # @since 1.0.0
    #
    class Name

      include Enumerable

      #
      # The parsed entries of the name.
      #
      # @return [Array<(String, String, Integer)>]
      #
      attr_reader :entries

      #
      # @param [OpenSSL::X509::Name] name
      #   The OpenSSL X509 name object.
      #
      def initialize(name)
        @name    = name
        @entries = name.to_a
      end

      #
      # Enumerates over the entries.
      #
      # @yield [oid, value, type]
      #
      # @yieldparam [String] oid
      #   The Object IDentifier.
      #
      # @yieldparam [String] value
      #   The entry's value.
      #
      # @yieldparam [Integer] type
      #   The entry type.
      #
      def each(&block)
        @entries.each do |(oid,value,type)|
          yield oid, value, type
        end
      end

      #
      # Finds the entry with the matcing OID (Object IDentifier).
      #
      # @param [String] key
      #
      # @return [String, nil]
      #
      def [](key)
        each do |oid,value,type|
          return value if oid == key
        end

        return nil
      end

      #
      # The Country (`C`) entry.
      #
      # @return [String]
      #
      def country_name
        @country_name ||= self['C']
      end

      alias country country_name
      alias c country_name

      #
      # The Common Name (`CN`) entry.
      #
      # @return [String]
      #
      def common_name
        @common_name ||= self['CN']
      end

      alias cn common_name

      #
      # The Domain Component (`DC`) entry.
      #
      # @return [String, nil]
      #
      def domain_component
        @domain_component ||= self['DC']
      end

      alias dc domain_component

      #
      # The Organization Name (`O`) entry.
      #
      # @return [String]
      #
      def organization_name
        @organization_name ||= self['O']
      end

      alias organization organization_name
      alias o organization_name

      #
      # The Organization Unit Name (`OU`) entry.
      #
      # @return [String]
      #
      def organizational_unit_name
        @organizational_unit_name ||= self['OU']
      end

      alias organizational_unit organizational_unit_name
      alias ou organizational_unit_name

      #
      # The State/Province Name (`ST`) entry.
      #
      # @return [String, nil]
      #
      def state_name
        @state_name ||= self['ST']
      end

      alias state state_name
      alias province_name state_name
      alias province province_name
      alias st state_name

      #
      # The Location (`L`) entry.
      #
      # @return [String, nil]
      #
      def location_name
        @location ||= self['L']
      end

      alias location location_name
      alias l location_name

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name#cmp-instance_method
      #
      def cmp(other)
        @name.cmp(other.name)
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name#eql%3F-instance_method
      #
      def eql?(other)
        @name.eql?(other.name)
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name#to_a-instance_method
      #
      def to_a
        @name.to_a
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name#to_der-instance_method
      #
      def to_der
        @name.to_der
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name#to_s-instance_method
      #
      def to_s(*args)
        @name.to_s(*args)
      end

      protected

      attr_reader :name

    end
  end
end
