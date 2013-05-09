class AddPhoneNumberToCigarStores < ActiveRecord::Migration
  def change
    add_column :cigar_stores, :phone_number, :string
  end
end
