require "spec_helper"

module Sales
  module Tax
    RSpec.describe CLI do
      subject { Sales::Tax::CLI.new }

      context "#load" do
        it "is expected to return list of Sales::Tax::Product instances" do
          file = File.dirname(__FILE__) + "/../support/receipt-1.txt"
          products = subject.load(file)

          products.each do |product|
            expect(product).to be_instance_of(Sales::Tax::Product)
          end
        end

        context "when file is not present" do
          it "is expected to raise FileNotExistsError" do
            path = File.dirname(__FILE__) + "/../support/test.txt"
            expect { subject.load(path) }.to raise_error(Sales::Tax::FileNotExistsError)
          end
        end

        context "when file format is not supported" do
          it "is expected to raise FileFormatNotSupportedError" do
            path = File.dirname(__FILE__) + "/../support/test.csv"
            expect { subject.load(path) }.to raise_error(Sales::Tax::FileFormatNotSupportedError)
          end
        end
      end

      context "#run" do
        context "with products" do
            let(:file) { File.dirname(__FILE__) + "/../support/receipt-1.txt" }
            let!(:products) { subject.load(file) }
            let!(:receipt) { Sales::Tax::Receipt.new(products) }
            context 'receipt-1.txt' do
                it "is expected to return the expected result" do
                    expected = subject.run(products)
        
                    expect(expected).to eq(
                        "1 book: 12.49 \n" +
                        "1 music cd: 16.49 \n" +
                        "1 chocolate bar: 0.85 \n" +
                        "Sales Taxes: 1.50 \n" +
                        "Total: 29.83"
                    )
                  end
            end

            context 'receipt-2.txt' do
                let(:file) { File.dirname(__FILE__) + "/../support/receipt-2.txt" }
                let!(:products) { subject.load(file) }
                let!(:receipt) { Sales::Tax::Receipt.new(products) }

                it "is expected to return the expected result" do
                    expected = subject.run(products)
        
                    expect(expected).to eq(
                        "1 imported box of chocolates: 10.50 \n" +
                        "1 imported bottle of perfume: 54.65 \n" +
                        "Sales Taxes: 7.65 \n" +
                        "Total: 65.15"
                    )
                  end
            end

            context 'receipt-3.txt' do
                let(:file) { File.dirname(__FILE__) + "/../support/receipt-3.txt" }
                let!(:products) { subject.load(file) }
                let!(:receipt) { Sales::Tax::Receipt.new(products) }

                it "is expected to return the expected result" do
                    expected = subject.run(products)
        
                    expect(expected).to eq(
                        "1 imported bottle of perfume: 32.19 \n" +
                        "1 bottle of perfume: 20.89 \n" +
                        "1 packet of headache pills: 9.75 \n" +
                        "1 box of imported chocolates: 11.85 \n" +
                        "Sales Taxes: 6.70 \n" +
                        "Total: 74.68"
                    )
                  end
            end
        end

        context "without products" do
            it "is expected to raise EmptyReceiptError" do
              expect { subject.run([]) }.to raise_error(Sales::Tax::EmptyReceiptError)
            end
        end
      end
    end
  end
end
