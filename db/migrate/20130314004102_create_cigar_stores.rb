class CreateCigarStores < ActiveRecord::Migration
  def change
    create_table :cigar_stores do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
