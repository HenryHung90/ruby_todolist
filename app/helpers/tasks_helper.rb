# frozen_string_literal: true

module TasksHelper
  def task_pry(pry)
    if pry == 'medium'
      'mid'
    else
      pry
    end
  end
end
