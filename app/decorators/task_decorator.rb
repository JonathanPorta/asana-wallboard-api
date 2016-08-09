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

  def is_due_soon
    if has_due_date && !is_past_due
      hours_until = (due_date - DateTime.now).to_i/3600
      if hours_until <= 36
        true
      else
        false
      end
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
        "Due #{ taiw } ago"
      else
        "Due in #{ taiw }"
      end
    else
      'No Due Date'
    end
  end

  def status
    if !has_due_date || !is_assigned
      'not-actionable'
    elsif is_past_due
      'past-due'
    elsif is_due_soon
      'due-soon'
    else
      'normal'
    end
  end

  def image
    if is_assigned
      if object.assignee.photo
        object.assignee.photo
      else
        # For users without an avatar
        'https://s3.amazonaws.com/general-web-assets/question-mark-mario-style-128x128.png'
      end
    else
      # For tasks without an assignee
      'https://s3.amazonaws.com/general-web-assets/exclamation-point-triangle-128x128.png'
    end
  end

  def tags
    tags = []
    if object.projects.length > 0
      object.projects.each do |p|
        tags.push p.name
      end
    end
    tags
  end
end
