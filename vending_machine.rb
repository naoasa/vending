# frozen_string_literal: true

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

  def enough_deposit?(item)
    # 預り金が足りている場合
    if @deposit >= item.price
      true
    else
      false
    end
  end

  def press_button(item) # 商品ボタンを押す
    # 紙カップ商品には紙カップ在庫数の判定が必要
    if item.class == PapercupCoffee # 紙カップ商品である場合
      if @cups >= 1 && enough_deposit?(item) # 紙カップ在庫数が1以上 かつ 預り金が十分
        # 紙カップを減らす
        @cups -= 1
        # 預り金を減らす
        @deposit -= item.price
        # 商品を返す
        item.name
      elsif @cups < 1 && enough_deposit?(item) # 紙カップ在庫数が1未満 かつ 預り金は十分
        "紙カップの在庫が足りません。補充してください。"
      else
        "お金が足りません。100円を入れてください。"
      end
    else # 紙カップ商品ではない場合
      if enough_deposit?(item) # お金が足りている場合
        # 預り金を減らす
        @deposit -= item.price
        # 商品を返す
        item.name
      else # お金が不足の場合
        "お金が足りません。100円を入れてください。"
      end
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

# スナック菓子の責務
class Snack < Item
  def initialize # 引数なし
    @name = "potato chips"
    @price = 150
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
ice_cup_coffee = PapercupCoffee.new("ice")
puts vending_machine.press_button(ice_cup_coffee)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(ice_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(ice_cup_coffee)
potato_chips = Snack.new
puts vending_machine.press_button(potato_chips)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(potato_chips)
