module Controller
  module ServiceUrlsConcern
    extend ActiveSupport::Concern

    included do
      helper_method :collection_path,
                    :call_service_path,
                    :invoke_service_path
    end

    def collection_path
      url_for(controller: controller_path, action: :index)
    end

    def invoke_service_path
      url_for(controller: controller_path, action: :invoke)
    end

    def call_service_path
      url_for(controller: controller_path, action: :call)
    end

    # def edit_service_path(service)
    #   url_for(controller: controller_path, action: :edit, id: service.to_param)
    # end

    # def service_path(service)
    #   url_for(controller: controller_path, action: :show, id: service.to_param)
    # end
  end
end
