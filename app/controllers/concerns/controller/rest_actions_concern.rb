module Controller
  module RestActionsConcern
    extend ActiveSupport::Concern

    included do
      respond_to :html
      responders :flash
    end

    def index
      @collection = collection_scope.all
      respond_with @collection
    end

    def new
      @resource = resource_class.new
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

    def load_resource
      resource_class.find(params[:id])
    end
  end
end
