# frozen_string_literal: true

module Sales
  module Tax
    class CLI
      ACCEPTED_INSTRUCTION_FORMATS = [".txt"].freeze

      def load(file)
        unless ACCEPTED_INSTRUCTION_FORMATS.include?(File.extname(file))
          raise Sales::Tax::FileFormatNotSupportedError, "Only txt files are supported currently."
        end

        raise Sales::Tax::FileNotExistsError, "File does not exist." unless File.exist?(file)

        File.readlines(file).drop(1).map do |entry|
          Sales::Tax::BuildProduct.run(entry)
        end
      end

      def run(products)
        raise Sales::Tax::EmptyReceiptError, "Receipt is empty" if products.size <= 0

        @receipt = Sales::Tax::Receipt.new(products)
        @result = Sales::Tax::ReceiptFormatter.format(@receipt)

        pp @result
      end
    end
  end
end
