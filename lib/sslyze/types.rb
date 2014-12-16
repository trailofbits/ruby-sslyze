module SSLyze
  module Types
    # Maps `"True"` and `"False"` to boolean values.
    Boolean = {
      'True' => true,
      'False' => false
    }

    # Maps `"None"` to `nil`
    None = proc { |value|
      case value
      when 'None' then nil
      else             value
      end
    }
  end
end
