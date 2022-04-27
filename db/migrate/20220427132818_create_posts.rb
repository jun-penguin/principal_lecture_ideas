class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.text :content
      t.integer :status
      t.integer :grade_range
      t.integer :scene_type

      t.timestamps
    end
  end
end
