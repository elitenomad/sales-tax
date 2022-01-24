# frozen_string_literal: true

require_relative "tax/version"
require_relative "tax/calculate"
require_relative "tax/product"
require_relative "tax/receipt"
require_relative "tax/receipt_formatter"
require_relative "tax/build_product"
require_relative "tax/cli"

module Sales
  module Tax
    class Error < StandardError; end
    class FileNotExistsError < StandardError; end
    class FileFormatNotSupportedError < StandardError; end
    class EmptyReceiptError < StandardError; end
  end
end
