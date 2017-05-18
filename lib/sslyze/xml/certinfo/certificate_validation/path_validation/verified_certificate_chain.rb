module SSLyze
  class XML
    class Certinfo < Plugin
      class CertificateValidation
        class PathValidation
          #
          # Represents the `<verifiedCertificateChain />` XML element.
          #
          # @since 1.0.0
          #
          class VerifiedCertificateChain

            include Types

          end
        end
      end
    end
  end
end
