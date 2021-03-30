class CreateAkiFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :aki_files do |t|
      t.string :filename
      t.string :contents
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
