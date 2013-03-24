class CreateCigarSearchLogs < ActiveRecord::Migration
  def change
    create_table :cigar_search_logs do |t|
      t.string :ip_address, null: false
      t.string :cigar, null: false

      t.timestamps
    end

    add_index :cigar_search_logs, [:ip_address, :cigar]
  end
end
