class RenameNameColumnToTitle < ActiveRecord::Migration[5.0]
  def change
    rename_column :blogs, :name, :title
  end
end
