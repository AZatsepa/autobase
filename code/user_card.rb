# Написать класс UserCard
# минимальный набор полей:
# паспортные данные (уникальное поле)
# текущий счет
# массив записей о прокате
# требования к функционалу:
# сделать запись о прокате
# посчитать долг пользователя
# удалить запись о прокате (или установить другой статус)
# минимальный набор ограничений:
# по собственному усмотрению

require './card_record.rb'
class UserCard
    attr_accessor :name,
                  :surname,
                  :id,
                  :account
                
    attr_reader   :history
    @@count = 0


  def initialize(name, surname)
    @name     = name
    @surname  = surname
    @@count   +=1
    @id       = @@count
    @account  =  1000
    @history  = []

  end

def make_record(id, car_number)
    record = CardRecord.new(id, car_number)
    @history << record
    record
  end

def remove_record(car_number)
    record = @history.find do |record| 
      record.car_number ==  car_number && record.status == :rent
    end
    
    record.status = :in_autobase
    record.return_time = Time.now
    @account -= record.days * 50
  end

  def plus_account(sum)
    @account += sum
  end


  def update_info
    @history.each do |record|
    end
  end

  def has_debt?
    @account < 0
  end

  def rent?(car_number)
    @history.find do |car|
      if car.status == :rent && car.car_number == car_number
      car
      end
    end
  end

  def cars_in_hire
    @history.find_all do |car|
      car.status == :rent
    end
  end

  def find_all_in_history(field, value)
    @history.find_all do |card_record|
      value == card_record.send(field.to_sym)
    end
  end

  def check
    result = 0
    @history.each do |record|
      if Time.now > record.time && record.status == :rent
       # @must_pay += (((Time.now - record.time) / 60 / 60 / 24) + 1).to_i * 50
          result += record.days * 50
      else
        0
      end
    end
    result
  end

  def to_s
     puts "=============User №#{@id}==============="
    puts "Name: #{@name}"
    puts "Surname: #{@surname}"
    puts "Cars in rent: #{self.cars_in_hire}"
    puts "Account: #{@account}"
    puts "Must pay: #{@must_pay}"
    puts '======================================='
    puts
  end
end


