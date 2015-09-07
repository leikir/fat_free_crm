class AddCategoryToAccount < ActiveRecord::Migration
  def change
    add_column :field_groups, :category_key, :string
    add_column :accounts, :category_key, :string
  end
end
