class Item < ApplicationRecord
  # before_save :apply_discount, if: :expensive?
  # before_save :notify_low_stock, unless: :in_stock?
  # before_save :apply_discount, if: Proc.new { price > 50 }
  # before_save :filter_content, if: [:expensive?, Proc.new { stock < 10 }]
  before_save :adjust_price, if: Proc.new { price > 100 }, unless: :in_stock?

  def apply_discount
    if price > 100
      self.price -= 10
      puts "Discount applied to item: #{name}"
    end
  end

  def notify_low_stock
    if stock < 10
      puts "Low stock warning for item: #{name}"
    end
  end

  def filter_content
    if price > 100
      self.name = "[FILTERED] #{name}"
      puts "Content filtered for item: #{name}"
    end
  end

  def adjust_price
    self.price -= 10
    puts "Price adjusted for item: #{name}. New price: #{price}"
  end

  private

  def expensive?
    price > 50
  end

  def in_stock?
    stock > 0
  end
end
