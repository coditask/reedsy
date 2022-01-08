module ItemHelper
  def formatted_price
    "#{number_with_precision(@total/100, precision: 2)}€"
  end
end