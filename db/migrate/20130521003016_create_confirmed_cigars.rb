class CreateConfirmedCigars < ActiveRecord::Migration
  def change
    create_table :confirmed_cigars do |t|
      t.string :name

      t.timestamps
    end
  end
end
