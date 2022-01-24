require "spec_helper"

module Sales
  module Tax
    RSpec.describe Receipt do
      subject { Sales::Tax::Receipt }

      context "#format" do
        file = File.dirname(__FILE__) + "/../support/receipt-1.txt"
        let(:products) { Sales::Tax::CLI.new.load(file) }
        let!(:receipt) { subject.new(products) }

        it "is expected to return total price and tax in an array" do
            expect(receipt.generate_report).to eq([29.83, 1.5])
        end
      end
    end
  end
end
