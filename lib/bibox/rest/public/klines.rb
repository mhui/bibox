module Bibox
  module Rest
    module Public
      module Klines
        
        # Pair: pair to lookup data OHLCV data for
        # Period: specific interval/period to group data for
          # Minutes: '1min', '5min', '10min', '15min' etc.
          # Hours: '1hour' etc.
          # Days: 'day'
        # Size: number of data points to return (1000 is maximum)
        def klines(pair: "BIX_ETH", period: '1min', size: 1_000, options: {})
          path        =   "/mdata"
          params      =   {cmd: "kline", pair: pair, period: period, size: size}
          response    =   parse(get(path, params: params, options: options))&.fetch("result", {})
          ::Bibox::Models::OHLCV.parse(response) if response
        end
      
      end
    end
  end
end
