class CreateTrials < ActiveRecord::Migration[5.0]
  def change
    create_table :trials do |t|
      t.string :name
      t.text :short_description
      t.text :long_description
      t.string :logo_url
      t.string :graphic_url

      t.timestamps
    end
  end
end
