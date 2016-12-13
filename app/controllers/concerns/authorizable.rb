module Authorizable
  extend ActiveSupport::Concern
  included do
    before_action :authorize_user
    before_action :authorize_entity, except: [:index, :new, :create]
    before_action :authorize_new, only: [:index, :new, :create] 
  end
  private
    def authorize_user
      unless current_user
        raise Pundit::NotAuthorizedError
      end
    end

    def authorize_entity
      authorize entity
    end

    def authorize_new
      authorize model.new
    end

    def entity
    end

    def model
    end
end