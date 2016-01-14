module Controller
  module ServiceActionsConcern
    extend ActiveSupport::Concern

    included do
      respond_to :html
      responders :flash
    end

    def index
    end

    def invoke
      @service = initialize_service
      respond_with @service
    end

    def call
      @service = prepare_service
      @response = @service.do_work
      if @response.success?
        render :success
      else
        render :invoke
      end
    end

    private

    def initialize_service
      service_class.new
    end

    def prepare_service
      service_class.new(permitted_params)
    end
  end
end
