class Records < ActiveRecord::Migration[5.2]
  def change
    drop_table :tag_maps
    drop_table :tags
  end
end
