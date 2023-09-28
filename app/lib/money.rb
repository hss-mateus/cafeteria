class Money
  attr_reader :value, :cents

  def initialize(value = nil, cents: nil)
    value_, cents_ =
      if value.present?
        [BigDecimal(value.to_s), BigDecimal(value.to_s) * BigDecimal("100")]
      elsif cents.present?
        [BigDecimal(cents.to_s) / BigDecimal("100"), BigDecimal(cents.to_s)]
      end

    @value = value_
    @cents = cents_
  end

  delegate :to_s, :to_i, :to_f, :+, :-, :*, :/, :as_json, to: :value

  def self.to_cents(value)
    new(value).cents.to_i
  end

  def self.to_value(cents)
    new(cents:).to_f
  end

  def coerce(other)
    [other, value]
  end
end
