# Написать класс CardRecord
# минимальный набор полей:
# id пользователя
# номер автомобиля
# время когда машина выдана в прокат
# время когда машина была возвращенна
# статус (оплачено, возвр. но не оплачено)
# требования к функционалу:
# изменение статуса записи + возврат суммы долга
# минимальный набор ограничений:
# по собственному усмотрению
class CardRecord
  attr_accessor :id,
                :car_number,
                :time,
                :return_time,
                :status

  def initialize(id, car_number)
    @id             = id
    @car_number     = car_number
    @time           = Time.now
    @status         = :rent
  end

  def days
    days = (((Time.now - @time) / 60 / 60 / 24) + 1).to_i
  end

  # def return_time
  #   @return_time = nil
  # end

  
end


