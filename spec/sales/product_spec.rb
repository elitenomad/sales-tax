require "spec_helper"

module Sales
  module Tax
    RSpec.describe Product do
      subject { Sales::Tax::Product }
      context "When the product is exempted" do
        let(:product) { subject.new(
            name: 'Book', 
            quantity: 2, 
            price: 15, 
            is_imported: false, 
            is_exempted: true
        )}

        it "is expected to return right total price" do
            expect(product.derive_total_price).to eq(30.0)
        end

        it "is expected to return right total price" do
            expect(product.derive_tax).to eq(0.0)
        end
      end

      context "When the product is not exempted" do
        let(:product) { subject.new(
            name: 'Umbrella', 
            quantity: 2, 
            price: 15, 
            is_imported: false, 
            is_exempted: false
        )}

        it "is expected to return right total price" do
            expect(product.derive_total_price).to eq(33.0)
        end

        it "is expected to return right total price" do
            expect(product.derive_tax).to eq(3.0)
        end
      end

      context "When the product is imported" do
        let(:product) { subject.new(
            name: 'imported Umbrella', 
            quantity: 2, 
            price: 15, 
            is_imported: true, 
            is_exempted: false
        )}

        it "is expected to return right total price" do
            expect(product.derive_total_price).to eq(34.5)
        end

        it "is expected to return right total price" do
            expect(product.derive_tax).to eq(4.5)
        end
      end

      context "When the product is imported and exempted" do
        let(:product) { subject.new(
            name: 'imported Book', 
            quantity: 2, 
            price: 15, 
            is_imported: true, 
            is_exempted: true
        )}

        it "is expected to return right total price" do
            expect(product.derive_total_price).to eq(31.5)
        end

        it "is expected to return right total price" do
            expect(product.derive_tax).to eq(1.5)
        end
      end
    end
  end
end
