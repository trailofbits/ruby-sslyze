require 'sslyze/x509/extension'
require 'sslyze/x509/domain'

require 'uri'
require 'ipaddr'

module SSLyze
  module X509
    module Extensions
      #
      # Represents the `subjectAltName` X509v3 extension.
      #
      # @since 1.0.0
      #
      class SubjectAltName < Extension

        include Enumerable

        # Known subject name types.
        TYPES = {
          'DNS' => :dns,
          'IP'  => :ip,
          'URI' => :uri,
          'RID' => :rid,

          'email'     => :email,
          'dirName'   => :dir_name,
          'otherName' => :other_name
        }

        #
        # Enumerates over every alternative name within the extension's value.
        #
        # @yield [type, name]
        #   The given block will be passed each 
        #
        # @yieldparam [:dns, :ip, :uri, :rid, :email, :dir_name, :other_name] type
        #   The type of the alternative name being yielded.
        #
        # @yieldparam [String] name
        #   An alternative name within the extension's value.
        #
        # @return [Enumerator]
        #   If no block is given, an Enumerator will be returned.
        #
        # @raise [NotImplementedError]
        #   An unknown name type was encountered while parsing the extension's
        #   value.
        #
        def each
          return enum_for unless block_given?

          value.split(', ').each do |type_value|
            type, value = type_value.split(':',2)

            unless TYPES.has_key?(type)
              raise(NotImplementedError,"unsupported subjectAltName type: #{type}")
            end

            yield TYPES[type], value
          end
        end

        #
        # All `DNS:` alternative names within the extension's value.
        #
        # @return [Array<String>]
        #
        def dns
          @dns ||= select { |type,value| type == :dns }.map do |(type,value)|
            value
          end
        end

        #
        # All `IP:` alternative names within the extension's value.
        #
        # @return [Array<IPAddr>]
        #
        def ip
          @ip ||= select { |type,value| type == :ip }.map do |(type,value)|
            IPAddr.new(value)
          end
        end

        #
        # All `URI:` alternative names within the extension's value.
        #
        # @return [Array<URI::Generic>]
        #
        def uri
          @uri ||= select { |type,value| type == :uri }.map do |(type,value)|
            URI.parse(value)
          end
        end

        #
        # All `email:` alternative names within the extension's value.
        #
        # @return [Array<String>]
        #
        def email
          @email ||= select { |type,value| type == :email }.map do |(type,value)|
            value
          end
        end

        #
        # All `RID:` alternative names within the extension's value.
        #
        # @return [Array<String>]
        #
        def rid
          @rid ||= select { |type,value| type == :rid }.map do |(type,value)|
            value
          end
        end

        #
        # All `dirName:` alternative names within the extension's value.
        #
        # @return [Array<String>]
        #
        def dir_name
          @dir_name ||= select { |type,value| type == :dir_name }.map do |(type,value)|
            value
          end
        end

        #
        # All `otherName:` alternative names within the extension's value.
        #
        # @return [Array<String>]
        #
        def other_name
          @other_name ||= select { |type,value| type == :other_name }.map do |(type,value)|
            value
          end
        end

      end
    end
  end
end
