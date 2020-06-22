module Api
  module V1
    class AppSerializer <  ActiveModel::Serializer
      # def attributes(*args)
      #   hash = super
      #   hash.each do |key, value|
      #     if value.nil?
      #       k = {}
      #       k[key] = ''
      #       hash = hash.merge(k)
      #     end
      #   end
      #   hash
      # end

      def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
        hash = super
        hash.each { |key, value| hash.delete(key) if value.nil? }
        hash
      end

    end
  end
end
