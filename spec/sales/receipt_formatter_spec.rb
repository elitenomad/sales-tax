require "spec_helper"

module Sales
  module Tax
    RSpec.describe ReceiptFormatter do
      subject { Sales::Tax::ReceiptFormatter }

      context "#format" do
        file = File.dirname(__FILE__) + "/../support/receipt-1.txt"
        let(:products) { Sales::Tax::CLI.new.load(file) }
        let!(:receipt) { Sales::Tax::Receipt.new(products) }

        it "is expected to return output with each product price, total price and sales taxes" do
            expect(subject.format(receipt)).to eq(
                "1 book: 12.49 \n" +
                "1 music cd: 16.49 \n" +
                "1 chocolate bar: 0.85 \n" +
                "Sales Taxes: 1.50 \n" +
                "Total: 29.83"
            )
        end
      end
    end
  end
end
