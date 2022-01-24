# frozen_string_literal: true

module Sales
  module Tax
    class Calculate
      SALES_TAX = 0.10
      IMPORT_TAX = 0.05
      NEAREST_ROUND_UP_VALUE = 0.05

      class << self
        def round_up(num)
          (num.to_f / NEAREST_ROUND_UP_VALUE).ceil * NEAREST_ROUND_UP_VALUE
        end

        def tax(price:, quantity:, is_imported:, is_exempted:)
          total_taxes = 0
          total_taxes += price * SALES_TAX unless is_exempted
          total_taxes += price * IMPORT_TAX if is_imported

          round_up(total_taxes).round(2) * quantity
        end
      end
    end
  end
end
