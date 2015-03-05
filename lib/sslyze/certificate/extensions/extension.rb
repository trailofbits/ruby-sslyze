module SSLyze
  class Certificate
    class Extensions
      class Extension

        def initialize(node)
          @node = node
        end

        def present?
          !@node.nil?
        end

      end
    end
  end
end
