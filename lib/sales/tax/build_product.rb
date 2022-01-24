# frozen_string_literal: true

module Sales
  module Tax
    class BuildProduct
      class << self
        def run(line)
          entry = Sales::Tax::Entry.new(line)

          Product.new(
            name: entry.name,
            quantity: entry.quantity,
            price: entry.price,
            is_imported: entry.imported?,
            is_exempted: entry.exempted?
          )
        end
      end
    end

    class Entry
      def initialize(line)
        @attrs = line.split(", ")
      end

      def name
        @attrs[1]
      end

      def quantity
        @attrs[0].to_i
      end

      def price
        @attrs[2].to_f
      end

      def imported?
        name.include? "imported"
      end

      def exempted?
        exempted_items = %w[book chocolate pills food medicine]
        exempted_items.any? { |item| @attrs[1].include?(item) }
      end
    end
  end
end
