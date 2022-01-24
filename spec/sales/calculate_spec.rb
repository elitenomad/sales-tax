require "spec_helper"

module Sales
  module Tax
    RSpec.describe Calculate do
      subject { Sales::Tax::Calculate }

      context ".round_up" do
        it "is expected to return nearest value to 0.05" do
            expect(subject.round_up(16.49)).to eq(16.5)
            expect(subject.round_up(16.59)).to eq(16.6)
            expect(subject.round_up(16.00)).to eq(16.0)
        end
      end

      context ".tax" do
        it "is expected to return right tax value based on various inputs" do
            expect(subject.tax(
                quantity: 2, 
                price: 15.0, 
                is_imported: true, 
                is_exempted: true
            )).to eq(1.5)

            expect(subject.tax(
                quantity: 2, 
                price: 15, 
                is_imported: true, 
                is_exempted: false
            )).to eq(4.5)

            expect(subject.tax(
                quantity: 2, 
                price: 15, 
                is_imported: false, 
                is_exempted: true
            )).to eq(0.0)

            expect(subject.tax(
                quantity: 2, 
                price: 15, 
                is_imported: false, 
                is_exempted: false
            )).to eq(3.0)
        end
      end
    end
  end
end
