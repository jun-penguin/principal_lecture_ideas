class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email,            null: false
      t.string :crypted_password
      t.string :salt
      t.integer :role, default: 0, null: false
      t.integer :status, default:0, null: false
      t.integer :prefecture, default:0, null: false
      t.text :self_introduction


      t.timestamps                null: false
    end
    add_index :users, :email, unique: true
  end
end
