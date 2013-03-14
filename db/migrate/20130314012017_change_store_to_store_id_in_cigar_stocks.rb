class ChangeStoreToStoreIdInCigarStocks < ActiveRecord::Migration
  def up
    remove_column :cigar_stocks, :store
    add_column :cigar_stocks, :cigar_store_id, :integer, null: false

    add_index :cigar_stocks, :cigar_store_id
    add_index :cigar_stocks, [:cigar_store_id, :cigar], unique: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
