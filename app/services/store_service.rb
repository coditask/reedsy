class StoreService

  class << self
    def total_price_of_items(store, item_codes)
      return 0 if item_codes.blank?

      codes = item_codes.split(',').map(&:strip)
      codes_group = Hash[codes.group_by(&:itself).map { |code, count| [code, count.size] }]
      items = store.items.where code: codes
      items.inject(0) do |sum, item|
        sum + BigDecimal(effective_item_price(item, codes_group))
      end
    end

    private

    def effective_item_price(item, codes_group)
      if item.percentage_discount_id? && codes_group[item.code] >= item.percentage_discount.minimum_items.to_i
        if item.percentage_discount.discounted_items.nil?
          non_discounted_items = 0
        else
          non_discounted_items = codes_group[item.code] - item.percentage_discount.discounted_items
        end
        (non_discounted_items + (codes_group[item.code] - non_discounted_items) * BigDecimal(((100 - item.percentage_discount.percentage)/100.0).to_s)) * item.price
      elsif item.free_discount_id? && codes_group[item.code] >= item.free_discount.minimum_items
        free_items = item.free_discount.free_items
        (codes_group[item.code] - free_items) * item.price
      else
        codes_group[item.code] * item.price
      end
    end
  end
end