class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :gender
      t.text :address

      t.timestamps
    end
  end
end
