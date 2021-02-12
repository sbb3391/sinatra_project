class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.belongs_to :user
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
