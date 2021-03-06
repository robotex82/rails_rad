module Controller
  module RestActionsConcern
    extend ActiveSupport::Concern

    included do
      respond_to :html
      responders :flash
    end

    abstract_method :permitted_params

    def index
      @collection = load_collection
      respond_with @collection
    end

    def new
      @resource = initialize_scope.new(permitted_params_for_new)
      respond_with @resource
    end

    def create
      @resource = initialize_scope.new(permitted_params)
      @resource.save
      respond_with @resource, location: after_create_location
    end

    def show
      @resource = load_resource
      respond_with @resource
    end

    def edit
      @resource = load_resource
      respond_with @resource
    end

    def update
      @resource = load_resource
      @resource.update_attributes(permitted_params)
      respond_with @resource, location: after_update_location
    end

    def destroy
      @resource = load_resource
      @resource.destroy
      respond_with @resource, location: after_destroy_location
    end

    private

    def permitted_params_for_new
      params.has_key?(resource_class.name.demodulize.underscore.to_sym) ? permitted_params : {}
    end

    def base_scope
      resource_class
    end

    def after_create_location
      @resource # collection_path
    end

    def after_destroy_location
      collection_path
    end

    def after_update_location
      @resource # collection_path
    end

    def collection_scope
      base_scope
    end

    def initialize_scope
      base_scope
    end

    def initialize_resource
      initialize_scope.new
    end
    
    def load_collection
      collection_scope.all
    end

    def load_scope
      base_scope
    end

    def load_resource
      load_scope.find(params[:id])
    end
  end
end
