class ChangeGoogleRefToText < ActiveRecord::Migration
  def change
    change_column :cigar_stores, :google_details_reference, :text
  end
end
