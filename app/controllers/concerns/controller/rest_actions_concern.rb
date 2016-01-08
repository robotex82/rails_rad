module Controller
  module RestActionsConcern
    extend ActiveSupport::Concern

    included do
      respond_to :html
      responders :flash
    end

    def index
      @collection = load_collection
      respond_with @collection
    end

    def new
      @resource = initialize_resource
      respond_with @resource
    end

    def create
      @resource = resource_class.new(permitted_params)
      @resource.save
      respond_with @resource, location: collection_path
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
      respond_with @resource, location: collection_path
    end

    def destroy
      @resource = load_resource
      @resource.destroy
      respond_with @resource, location: collection_path
    end

    private

    def collection_scope
      resource_class
    end

    def initialize_resource
      resource_class.new
    end
    
    def load_collection
      collection_scope
    end

    def load_resource
      resource_class.find(params[:id])
    end
  end
end
