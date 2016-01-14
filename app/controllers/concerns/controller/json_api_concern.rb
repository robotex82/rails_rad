module Controller
  module JsonApiConcern
    extend ActiveSupport::Concern

    included do
      respond_to :json
    end
  end
end
