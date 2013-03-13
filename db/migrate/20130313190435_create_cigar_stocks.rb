class CreateCigarStocks < ActiveRecord::Migration
  def change
    create_table :cigar_stocks do |t|
      t.string :store, null: false
      t.string :cigar, null: false
      t.boolean :carried, null: false

      t.timestamps
    end

    add_index :cigar_stocks, :cigar
    add_index :cigar_stocks, [:store, :cigar], unique: true
  end
end
