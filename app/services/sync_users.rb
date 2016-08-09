class SyncUsers
  def initialize
    @asana_api = AsanaApi.new
  end

  def call
    users = @asana_api.users.map do |d|
      # Extract the persisted fields
      user_data = {
        id: d.id,
        name: d.name,
        email: d.email,
        photo: (d.photo != nil ? d.photo['image_128x128'] : nil) # pic (ha!) the larger photo if the user has one
      }

      user = User.find_by(id: user_data[:id]) || User.new(user_data)

      if user.persisted?
        user.update! user_data # update if user is already in the database
        Rails.logger.info "Updated User: #{ user.id }, #{ user.name }"
      else
        user.save! # save if the user is new to the database
        Rails.logger.info "Inserted User: #{ user.id }, #{ user.name }"
      end

      user
    end

    # Remove users that are no longer in the API
    User.where.not(id: users.map(&:id)).destroy_all.each do |removed|
      Rails.logger.info "Removed User: #{ removed.id }, #{ removed.name }"
    end

    users
  end
end
