class WelcomeController < ApplicationController
  def index
  end
  def product_template
    @id = params[:id]
    @name = params[:name]
    @base_price = params[:base_price]
    @description = params[:description]
    @quantity_on_hand = params[:quantity_on_hand]
    @color = params[:color]
    @weight = params[:weight]

    render partial: 'product_template'
  end
end
