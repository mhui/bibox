module Bibox
  module Rest
    module Private
      module Orders
        
        def buy(pair:, price:, amount:, order_type: :limit, pay_fees_with_bix: true, options: {})
          perform_order(
            pair:               pair,
            price:              price,
            amount:             amount,
            order_side:         :buy,
            order_type:         order_type,
            pay_fees_with_bix:  pay_fees_with_bix,
            options:            options
          )
        end
        
        def sell(pair:, price:, amount:, order_type: :limit, pay_fees_with_bix: true, options: {})
          perform_order(
            pair:               pair,
            price:              price,
            amount:             amount,
            order_side:         :sell,
            order_type:         order_type,
            pay_fees_with_bix:  pay_fees_with_bix,
            options:            options
          )
        end
        
        def perform_order(pair:, price:, amount:, order_side: :buy, order_type: :limit, account_type: 0, pay_fees_with_bix: true, options: {})
          params      =   {
            pair:           pair,
            account_type:   account_type,
            order_type:     Bibox::Models::Order::ORDER_TYPES[order_type],
            order_side:     Bibox::Models::Order::ORDER_SIDES[order_side],
            pay_bix:        pay_fees_with_bix.eql?(true) ? 1 : 0,
            price:          price,
            amount:         amount,
            money:          (price * amount),
          }
          
          payload     =   [
            {
              cmd:  "orderpending/trade",
              body: params
            }
          ]
          
          response    =   parse(post("/orderpending", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})&.to_s
        end
        
        def cancel_order(order_id, options: {})
          payload     =   [
            {
              cmd:  "orderpending/cancelTrade",
              body: {orders_id: order_id}
            }
          ]
          
          response    =   parse(post("/orderpending", data: payload, options: options))
          
          return true
        end
        
        # A currency pair can be specified using its code, e.g. BIX_ETH
        # Or separately using coin_symbol and currency_symbol (which the Bibox UI seems to use)
        
        def pending_orders(pair: nil, page: 1, size: 10, coin_symbol: nil, currency_symbol: nil, order_side: nil, account_type: nil, options: {})          
          params      =   {
            pair:             pair,
            page:             page,
            size:             size,
            coin_symbol:      coin_symbol,
            currency_symbol:  currency_symbol,
            order_side:       order_side,
            account_type:     account_type,
          }
          
          return list_orders(type: :pending, params: params, options: options)
        end
        
        def order_history(pair: nil, page: 1, size: 10, hide_cancel: nil, coin_symbol: nil, currency_symbol: nil, order_side: nil, account_type: nil, options: {})
          params      =   {
            pair:             pair,
            page:             page,
            size:             size,
            hide_cancel:      hide_cancel,
            coin_symbol:      coin_symbol,
            currency_symbol:  currency_symbol,
            order_side:       order_side,
            account_type:     account_type,
          }
          
          return list_orders(type: :history, params: params, options: options)
        end
        
        def list_orders(type: :pending, params: {}, options: {})          
          params[:page]            ||=   1
          params[:size]            ||=   10
          
          command   =   case type
            when :pending
              "orderpending/orderPendingList"
            when :history
              "orderpending/orderHistoryList"
          end
          
          params.delete_if { |key, value| value.nil? }
          
          case params[:order_side]
            when 1, :buy
              params[:order_side] = ::Bibox::Constants::BUY_ORDER
            when 2, :sell
              params[:order_side] = ::Bibox::Constants::SELL_ORDER
          end
          
          payload     =   [
            {
              cmd:  command,
              body: params
            }
          ]
          
          response    =   parse(post("/orderpending", data: payload, options: options))&.fetch("result", [])&.first&.fetch("result", {})&.fetch("items", [])
          ::Bibox::Models::Order.parse(response) if response&.any?
        end
      
      end
    end
  end
end
