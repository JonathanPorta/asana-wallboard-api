json.array!(@tasks) do |task|
  json.extract! task, :id, :label, :image, :is_assigned, :has_due_date, :due_date_in_words, :due_date
end
