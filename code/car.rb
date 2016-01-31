# Написать класс Car
# минимальный набор полей:
# марка
# модель
# номер (уникальный)
# статус (в прокате / на базе)
# требования к функционалу:
# по собственному усмотрению
# минимальный набор ограничений:
# по собственному усмотрению
class Car
  attr_reader   :mark,
                :model,
                :car_number
  attr_accessor :status,
                :cost
  @@number = 0

  def initialize(mark, model)
    @cost       = 100
    @mark       = mark
    @model      = model
    @@number    += 1
    @car_number = @@number
    @status     = :in_autobase
  end



def change_status
    case @status
    when :in_autobase
      @status = :rent
    when :rent
      @status = :in_autobase
    end
  end

  def to_s
    puts "=============CAR №#{@car_number}==============="
    puts "Mark: #{@mark}"
    puts "Model: #{@model}"
    puts "Status: #{@status}"
    puts "Cost: #{@cost}"
    puts '======================================='
    puts
  end
end
