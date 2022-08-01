class ChangeColumnsAddNotnullOnPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :title, :string, null: false
    change_column :posts, :description, :text, null: false
    change_column :posts, :content, :text, null: false
    change_column :posts, :status, :integer, null: false
    change_column :posts, :grade_range, :integer, null: false
    change_column :posts, :scene_type, :integer, null: false
  end
end
