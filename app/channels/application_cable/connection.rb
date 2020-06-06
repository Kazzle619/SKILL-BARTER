module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      verified_user = request.env['warden'].user
      if verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
      # verified_user = User.find_by(id: env['warden'].user.id)
      # return reject_unauthorized_connection unless verified_user
      # verified_user
    end
  end
end
