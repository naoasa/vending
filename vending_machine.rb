# frozen_string_literal: true

require "debug"

# 自動販売機の責務
class VendingMachine
  def initialize(name)
    @manufacturer_name = name
    @deposit = 0
    @cups = 0
  end

  def deposit_coin(coin)
    if coin == 100
      @deposit += 100
    end
  end

  def add_cup(num) # 紙カップを補充する
    @cups += num.to_i
    # 紙カップの数は0以上100以下の整数
    if @cups < 0
      @cups = 0
    elsif @cups > 100
      @cups = 100
    end
  end

  def press_button(item) # 商品ボタンを押す
    # 預り金が商品価格以上ある場合
    if @deposit >= item.price
      @deposit -= item.price # 預り金を減らす
      item.name # 商品を返す
    else
      "お金が足りません"
    end
  end

  private
    def get_manufacturer_name
      @manufacturer_name
    end
end

# アイテムの責務
class Item
  attr_reader :name, :price

  def initialize(name)
    @name = name
    @price = nil
  end
end

# 飲み物の責務
class Drink < Item
  def initialize(name)
    case name
    when "cider"
      @price = 100
      @name = "cider"
    when "cola"
      @price = 150
      @name = "cola"
    end
  end
end

# カップコーヒーの責務
class PapercupCoffee < Item
  def initialize(name)
    case name
    when "hot"
      @name = "hot cup coffee"
      @price = 100
    when "ice"
      @name = "ice cup coffee"
      @price = 100
    end
  end
end

# 実行
vending_machine = VendingMachine.new("サントリー")
cola = Drink.new("cola")
puts vending_machine.press_button(cola)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
vending_machine.add_cup(1)