# Написать основной класс Autobase
# минимальный набор полей:
# массив, хранилище для всех автомобилей которые есть на базе
# регистр пользователей (массив с пользователями)
# поточный счет автобазы

# требования к функционалу:
# взять машину в прокат
# вернуть машину из проката
# оплатить задолженность (расчет задолженности считается по количеству дней которые автомобиль был в прокате)
# закупить новые автомобили
# вывод на консоль информации по автомобилям
# поиск автомобиля по марке
# минимальный набор ограничений:
# нельзя взять в прокат автомобиль если он уже находится в прокате
# нельзя выдать автомобиль в прокат если у пользователя есть задолженность
require './car.rb'
require './card_record.rb'
require './user_card.rb'
require './cars_for_hire.rb'
require 'byebug'
require 'faker'

class AutoBase

  attr_accessor :name,
                :cars,
                :user_cards,
                :account

  def initialize(name)
    @name       = name
    @cars       = []
    @user_cards = []
    @account    = 1000
  end 


 def buy_car
    mark = ['Buick', 'Cadillac', 'Chevrolet', 'Dodge', 'Ford'].sample
     buick = ['LaCrosse',
             'Lucerne',
             'Allure',
             'Enclave',
             'Regal']

    cadillac = ['Caterra',
                'Seville V ',
                'Escalade I',
                'Sedan de Ville VIII',
                'Escalade II',
                'Escalade EXT I',
                'CTS I',
                'CTS-V I',
                'SRX I',
                'XLR',
                'STS I',
                'STS-V',
                'BLS',
                'DTS',
                'Escalade III']

    chevrolet = ['Corvette',
                 'Cruze',
                 'Deluxe',
                 'Del Ray',
                 'El Camino',
                 'Epica',
                 'Equinox',
                 'Evanda',
                 'Express',
                 'Fleetline',
                 'Fleetmaster',
                 'Forester']

    dodge = ['Avenger',
             'Brisa',
             'Caliber',
             'Challenger',
             'Charger',
             'Magnum',
             'Viper']

    ford = ['Maverick',
            'Mondeo',
            'Mustang',
            'Orion',
            'Probe',
            'Puma',
            'S-MAX',
            'Ranger',
            'Scorpio',
            'Sierra',
            'Superduty',
            'Taunus',
            'Taurus',
            'Thunderbird']
    case
      when mark == 'Buick'
        model = buick.sample
      when mark == 'Cadillac'
        model = cadillac.sample
      when mark == 'Chevrolet'
        model = chevrolet.sample
      when mark == 'Dodge'
        model = dodge.sample
      when mark == 'Ford'
        model = ford.sample
    end
    car = Car.new(mark, model)
    @cars << car
    @account -= car.cost
    car
  end


  def buy_cars
    while @account >= 100
      car = buy_car
      try_buy(car)
    end
  end

  def try_buy(car)
    return false if @account < car.cost
    # @cars << car
    # @account -= car.cost
  end

  def add_user
      name    = Faker::Name.first_name
      surname = Faker::Name.last_name
     user = UserCard.new(name, surname)
     @user_cards << user
     user.id
  end

   def find_user_card(user_id)
    @user_cards.find { |user_card| user_card.id == user_id }
  end

  def all_cars_info
    @cars.each do |car|
      car.to_s
    end
    puts
  end

  def find_car_by(by, value)
    @cars.find do |car|
      value == car.send(by.to_sym)
    end
  end

   def find_all_cars_by(by, value)
    @cars.find_all do |car|
      value == car.send(by.to_sym)
    end
  end

  def car_present?(car)
    return false if car.nil?
    car.status == :in_autobase
  end

  def pay(user_id, sum)
    user_card = find_user_card(user_id)
    user_card.plus_account(sum)
    # user_card.account += sum
  end

  def return_car(car_number, user_id)
    user_card = find_user_card(user_id)
    car       = user_card.find_all_in_history(:status, :rent)

    car.each do |car_in_history|
      if car_in_history.car_number == car_number
        @account += car_in_history.days * 50
        user_card.remove_record(car_number)
        car_in_history.status = :in_autobase
        car_change = self.find_car_by(:car_number, car_in_history.car_number)
        car_change.status = :in_autobase
      end 
    end
    
  end

   def rental(car_number, user_id)
    user_card = find_user_card(user_id)
    car       = find_car_by(:car_number, car_number)
    unless car_present?(car)
      puts 'Car not present!'
      return   
    end
    if debt?(user_card)
      #please_pay(user_card.plus_account(50))
      puts "please, pay user account"
    else
      user_card.make_record(user_id, car_number)
      car.status = :rent
    end
  end

  def debt?(user_card)
    # user_card.check
    return true if user_card.check > user_card.account
    false
  end

  def info
    puts "=============Autobase {@name}==============="
    puts "Cars:"
    self.all_cars_info
    puts "Users:"
    self.all_users_info
    puts "Account: #{@account}"
    puts '======================================='
    puts
  end

  def all_users_info
    @user_cards.each do |user_card|
      user_card.to_s
    end
    puts
  end

  # private

  #   def please_pay(sum)
  #     puts "Пожалуйста погасите задолженость #{sum} грн."
  #   end

end
