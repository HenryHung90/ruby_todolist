# frozen_string_literal: true

# TasksHelper
module TasksHelper
  def task_pry(pry)
    if pry == 'medium'
      'mid'
    else
      pry
    end
  end
end
