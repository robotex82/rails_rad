module Controller
  module JsonApiConcern
    extend ActiveSupport::Concern

    included do
      respond_to :json
    end

    def index
      @collection = load_collection

      @collection = add_filter_to_scope(@collection) if (['only'] & params.keys).any?
      @collection = add_includes_to_scope(@collection) if included_associations.any?
      @collection = add_count_to_scope(@collection) if params[:count]

      respond_to do |format|
        format.json {  render json: @collection, include: included_associations  }
      end
    end

    private

    def add_filter_to_scope(scope)
      scope.select(*params[:only].split(',')) if params[:only]
    end

    def add_includes_to_scope(scope)
      included_associations.each do |include|
        scope = scope.send(:includes, include)
      end
      scope
    end

    def add_count_to_scope(scope)
      scope.count
    end

    def included_associations
      params[:includes].respond_to?(:split) ? params[:includes].split(',') : []
    end
  end
end
