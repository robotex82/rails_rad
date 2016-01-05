module Controller
  module ResourceConcern
    extend ActiveSupport::Concern

    class_methods do
      def resource_class
        name.gsub('Controller', '').constantize
      end
    end

    def resource_class
      self.class.resource_class
    end
  end
end
