class AddAddressToCigarStores < ActiveRecord::Migration
  def change
    add_column :cigar_stores, :address, :string
  end
end
