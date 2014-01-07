class UserController < ApplicationController
  def setup
    user = User.pending.where("dish_id IN (#{restaurant_serving_dishes})")
  end
end