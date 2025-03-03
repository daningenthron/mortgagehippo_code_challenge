class CoinsController < ApplicationController
  before_action :find_coin, only: [:show, :update, :destroy]

  def index
    @coins = Coin.all
    render json: @coins, :meta => {:total => Coin.total}
  end

  def show
    json_response(@coin)
  end

  def create
    @coin = Coin.create!(coin_params.merge(name: Coin.coin_name(coin_params)))
    json_response(@coin, :created)
  end

  def update
    @coin.update(coin_params.merge(name: Coin.coin_name(coin_params)))
    head :no_content
  end

  def destroy
    @coin.destroy
    head :no_content
  end

  def total
    @coins = []
    render json: @coins, :meta => {:total => Coin.total}
  end

  private

  def coin_params
    params.permit(:value)
  end

  def find_coin
    @coin = Coin.find(params[:id])
  end
end
