json.array!(@tasks) do |task|
  json.extract! task, :id, :status, :label, :image, :is_assigned, :has_due_date, :due_date_in_words, :due_date, :is_past_due, :is_due_soon, :tags
end
