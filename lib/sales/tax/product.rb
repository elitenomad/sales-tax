# frozen_string_literal: true

module Sales
  module Tax
    class Product
      attr_reader :name, :quantity, :is_imported, :is_exempted, :taxes, :price

      def initialize(name:, quantity:, price:, is_imported:, is_exempted:)
        @name = name
        @quantity = quantity
        @is_imported = is_imported
        @is_exempted = is_exempted
        @price = price
      end

      def derive_tax
        Sales::Tax::Calculate.tax(
          price: @price,
          quantity: @quantity,
          is_imported: @is_imported,
          is_exempted: @is_exempted
        )
      end

      def derive_total_price
        ((@quantity * @price) + derive_tax).round(2)
      end
    end
  end
end
