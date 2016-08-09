class TaskDecorator < Draper::Decorator

  delegate :id

  def label
    object.name
  end

  def is_assigned
    if object.assignee
      true
    else
      false
    end
  end

  def has_due_date
    if due_date != nil
      true
    else
      false
    end
  end

  def is_past_due
    if has_due_date
      due_date.past?
    else
      false
    end
  end

  def due_date
    if object.due_at
      object.due_at
    elsif object.due_on
      object.due_on
    else
      nil
    end
  end

  def due_date_in_words
    if has_due_date
      taiw = helpers.time_ago_in_words(due_date)
      if is_past_due
        "#{ taiw } ago"
      else
        "in #{ taiw }"
      end
    else
      'No Due Date'
    end
  end

  def image
    if is_assigned
      object.assignee.photo
    else
      'https://s3.amazonaws.com/general-web-assets/exclamation-point-triangle-128x128.png'
    end
  end
end
