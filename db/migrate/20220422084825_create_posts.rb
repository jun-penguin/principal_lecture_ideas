class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :description
      t.text :content, null: false
      t.integer :status, default: 0, null: false
      t.integer :grade_range, default: 0, null: false
      t.integer :scene_type, default: 0, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
