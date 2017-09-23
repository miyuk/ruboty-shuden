require 'ruboty/shuden/actions/save_route'
require 'ruboty/shuden/actions/show_route'
require 'ruboty/shuden/actions/show_last_train'

module Ruboty
  module Handlers
    class Shuden < Base
      on(
        /.*(終電|shuden|traceroute).*/m,
        all: true,
        name: 'show_last_train',
        description: '終電検索'
      )

      on(
        /save route (?<origin>.*?) (?<dest>.*?)\z/,
        name: 'save_route',
        description: '帰宅ルートの保存'
      )

      on(
        /show route\z/,
        name: 'show_route',
        description: '帰宅ルートの表示'
      )

      def show_last_train(message)
        Ruboty::Shuden::Actions::ShowLastTrain.new(message).call
      end

      def save_route(message)
        Ruboty::Shuden::Actions::SaveRoute.new(message).call
      end

      def show_route(message)
        Ruboty::Shuden::Actions::ShowRoute.new(message).call
      end
    end
  end
end
