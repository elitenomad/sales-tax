require "spec_helper"

module Sales
  module Tax
    RSpec.describe BuildProduct do
      subject { Sales::Tax::BuildProduct }

      context ".run" do
        it "is expected to transform a string into product instance" do
            expected = Sales::Tax::Product.new(
                name: 'book', 
                quantity: 1, 
                price: 12.49, 
                is_imported: false, 
                is_exempted: true
            )

            expect(subject.run("1, book, 12.49")).to be_instance_of(Sales::Tax::Product)
        end

        it "is expected to return values as expected" do
            expected = Sales::Tax::Product.new(
                name: 'book', 
                quantity: 1, 
                price: 12.49, 
                is_imported: false, 
                is_exempted: true
            )
            result = subject.run("1, book, 12.49")

            expect(result.name).to eq(expected.name)
            expect(result.quantity).to eq(expected.quantity)
            expect(result.price).to eq(expected.price)
            expect(result.is_imported).to eq(expected.is_imported)
            expect(result.is_exempted).to eq(expected.is_exempted)
        end
      end
    end
  end
end
