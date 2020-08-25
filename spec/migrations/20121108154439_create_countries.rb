class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.boolean :landlocked, null: true
      t.timestamps
    end
  end
end
