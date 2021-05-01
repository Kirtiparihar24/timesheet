class CreateTimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_entries do |t|
      t.datetime :clock_in, null: false
      t.datetime :clock_out
      t.text :detail
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
