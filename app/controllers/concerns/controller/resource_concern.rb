module Controller
  module ResourceConcern
    extend ActiveSupport::Concern

    included do
      helper_method :resource_class
    end

    class_methods do
      def resource_class
        name.gsub('Controller', '').constantize
      end

      def resource_count
        resource_class.count
      end
    end

    def resource_class
      self.class.resource_class
    end
  end
end
