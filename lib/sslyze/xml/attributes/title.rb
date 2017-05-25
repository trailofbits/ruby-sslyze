module SSLyze
  class XML
    module Attributes
      module Title
        #
        # The title.
        #
        # @return [String, nil]
        #   The value of the `title` attribute.
        #
        def title
          @title ||= @node['title']
        end

        #
        # The title or an empty String.
        #
        # @return [String]
        #
        def to_s
          title || ''
        end
      end
    end
  end
end
