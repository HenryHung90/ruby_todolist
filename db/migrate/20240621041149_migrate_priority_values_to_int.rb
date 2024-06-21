class MigratePriorityValuesToInt < ActiveRecord::Migration[7.1]
  def up
    Task.where(priority: 'high').update_all(priority_int: 1)
    Task.where(priority: 'medium').update_all(priority_int: 2)
    Task.where(priority: 'low').update_all(priority_int: 3)
  end

  def down
    # 可选：回滚时将整数值转换回字符串
    Task.where(priority_int: 1).update_all(priority: 'high')
    Task.where(priority_int: 2).update_all(priority: 'medium')
    Task.where(priority_int: 3).update_all(priority: 'low')
  end
end
