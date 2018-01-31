module Bibox
  module Models
    class UserAssets < Base      
      attr_accessor :assets
      
      MAPPING     =   {
        total_btc:      :float,
        total_cny:      :float,
        total_usd:      :float,
      }
      
      def initialize(hash)
        super(hash)
        process(hash.fetch("assets_list", []))
      end
      
      def process(assets)
        self.assets   =   ::Bibox::Models::Asset.parse(assets)
      end
      
    end
  end
end
