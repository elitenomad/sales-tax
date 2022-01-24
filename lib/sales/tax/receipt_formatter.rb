# frozen_string_literal: true

module Sales
  module Tax
    class ReceiptFormatter
      def self.format(receipt)
        report = ""
        receipt.products.each do |product|
          report += "#{product.quantity} #{product.name}: #{format("%0.02f", product.derive_total_price)} \n"
        end

        report += "Sales Taxes: #{format("%.02f", receipt.generate_report[1])} \n"
        report += "Total: #{format("%.02f", receipt.generate_report[0])}"
      end
    end
  end
end
