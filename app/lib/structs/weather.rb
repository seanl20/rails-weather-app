module Structs
  class Weather < Dry::Struct
    transform_keys(&:to_sym)

    attribute :icon_url, Types::String
    attribute :main, Types::String
    attribute :description, Types::String
    attribute :temp, Types::Float
  end
end