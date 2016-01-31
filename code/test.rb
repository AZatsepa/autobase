require './car.rb'
require './card_record.rb'
require './user_card.rb'
require './cars_for_hire.rb'
require './autobase.rb'
require 'byebug'
require 'faker'

base = AutoBase.new('АТП 16307')
base.buy_cars
base.all_cars_info
  5.times do
    base.add_user
  end
user = base.find_user_card(1)
car = base.find_car_by(:car_number, 9)
base.rental(9, 1)
base.rental(8, 1)
byebug
base.rental(7, 1)

base.add_user
