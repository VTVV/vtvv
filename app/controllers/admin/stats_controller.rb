module Admin
  class StatsController < ApplicationController
    def index
      @from = params.dig(:stats,:from) || Date.today - 5.year
      @to = params.dig(:stats,:to) || Date.today
      @common_stats = InfoService.get_common_money_stats(@from, @to)
    end
  end
end
