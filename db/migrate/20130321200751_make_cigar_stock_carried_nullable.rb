class MakeCigarStockCarriedNullable < ActiveRecord::Migration
  def up
    change_column :cigar_stocks, :carried, :boolean, null: true
  end

  def down
    change_column :cigar_stocks, :carried, :boolean, null: false
  end
end
