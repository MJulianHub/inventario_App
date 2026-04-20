class AddDefaultToActiveInProducts < ActiveRecord::Migration[8.1]
  def change
    change_column_default :products, :active, true
    change_column_null :products, :active, false
  end
end
