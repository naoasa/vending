# frozen_string_literal: true

require "debug"

# 自動販売機の責務
class VendingMachine
  def initialize(name)
    @manufacturer_name = name
  end

  private
    def get_manufacturer_name
      @manufacturer_name
    end
end

# 実行
vending_machine = VendingMachine.new("サントリー")
