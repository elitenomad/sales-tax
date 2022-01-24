# frozen_string_literal: true

module Sales
  module Tax
    class Receipt
      attr_reader :products

      def initialize(products)
        @products = products
      end

      def generate_report
        [calculate_total, calculate_taxes]
      end

      private

      def calculate_taxes
        total_taxes = 0
        @products.each do |product|
          total_taxes += product.derive_tax
        end

        total_taxes.round(2)
      end

      def calculate_total
        total_cost = 0
        @products.each do |product|
          total_cost += product.derive_total_price
        end

        total_cost.round(2)
      end
    end
  end
end
