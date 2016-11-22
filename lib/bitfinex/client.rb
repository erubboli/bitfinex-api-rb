module Bitfinex
  class Client
    include Bitfinex::RestConnection
    include Bitfinex::WebsocketConnection
    include Bitfinex::AuthenticatedConnection
    include Bitfinex::Configurable

    V1_MODULES = [
      Bitfinex::V1::TickerClient,
      Bitfinex::V1::TradesClient,
      Bitfinex::V1::FundingBookClient
    ]

    V2_MODULES = []
  end
end
