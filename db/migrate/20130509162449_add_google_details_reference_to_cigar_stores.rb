class AddGoogleDetailsReferenceToCigarStores < ActiveRecord::Migration
  def change
    add_column :cigar_stores, :google_details_reference, :string
  end
end
