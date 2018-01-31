module Bibox
  module Models
    class OrderBook
      attr_accessor :pair, :update_time, :asks, :bids
    
      def initialize(hash)
        self.pair           =   hash.fetch("pair", nil)
        self.update_time    =   ::Bibox::Utilities.epoch_to_time(hash.fetch("update_time", nil), ms: true) if hash.has_key?("update_time") && !hash.fetch("update_time", nil).to_s.empty?
        
        self.bids           =   []
        self.asks           =   []

        process(hash)
      end
      
      def process(hash)
        [:bids, :asks].each do |type|
          hash.fetch(type.to_s, []).each do |item|
            price     =   ::Bibox::Utilities.convert_value(item.fetch("price", nil), :float)
            volume    =   ::Bibox::Utilities.convert_value(item.fetch("volume", nil), :float)
            value     =   !price.nil? && !volume.nil? ? price * volume : nil
            self.send(type).send(:<<, {price: price, volume: volume, value: value})
          end
        end
      end

    end
  end
end
