class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :users, :profile_image_id, true
  end

  def down
    change_column_null :users, :profile_image_id, false
  end
end
