class ChangeDefaultStockInProducts < ActiveRecord::Migration[8.1]
  def change
    change_column_default :products, :stock, 0
    change_column_null :products, :stock, false
  end
end
