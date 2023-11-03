class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # TODO: Remove this method on later Rails updates
  def deconstruct_keys(keys)
    deconstructed = {}

    keys.each do |key|
      deconstructed[key] = send(key)
    end

    deconstructed
  end

  def self.human_enum_name(enum_name, enum_value)
    return "" unless enum_value

    name = enum_name.to_s.pluralize
    enum_hash = try(name) || try(enum_name.to_s).instance_variable_get(:@value_hash)

    value =
      if enum_hash[enum_value].present?
        enum_value
      else
        enum_hash.invert.to_h { |k, v| [k.to_s, v] }.dig(enum_value.to_s)
      end

    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{name}.#{value}")
  end
end
