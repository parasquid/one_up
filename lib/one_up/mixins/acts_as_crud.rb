module OneUp
  module Mixins
    module ActsAsCrud
      def crud_element_list
        @@crud_element_list ||= []
      end

      def crud_element_list=(new_list)
        @@crud_element_list = new_list
      end

      def create(args)
        self.crud_element_list << (element = self.new(args))
        element
      end

      def all
        self.crud_element_list
      end

      def delete_all
        self.crud_element_list.clear
      end
    end
  end
end