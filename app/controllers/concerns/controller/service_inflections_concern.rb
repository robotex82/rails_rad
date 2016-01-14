module Controller
  module ServiceInflectionsConcern
    extend ActiveSupport::Concern

    included do
      helper_method :inflections
    end

    private

    def inflections
      {
        service_name: t("classes.#{service_class.name.underscore}")
      }
    end
  end
end
