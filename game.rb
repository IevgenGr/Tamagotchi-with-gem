# frozen_string_literal: true

require 'GetSaveGem'
require_relative 'pet'

class Game
  def create_pet
    @pet = Pet.new
    puts 'Питомец родился!',
         'Дайте ему имя:'
    @pet.name = gets.chomp.capitalize
    html
  end

  def start_game
    create_pet
    help
    GetSaveGem.new.system("xdg-open" + "index.html")

    while  @pet.life.positive?
      puts 'Выберите действие: ',
           '  1  -  информация о питомце',
           '  2  -  играть с питомцем',
           '  3  -  напоить питомца',
           '  4  -  накормить питомца',
           '  5  -  положить спать',
           '  6  -  пойти к ветеринару',
           '  7  -  пойти на дрессировку',
           '  8  -  пойти на охоту',
           '  9  -  помыть',
           '  10 -  сводить в туалет',
           '  11 -  убить? что? кого? \n',
           '  q - закрыть игру \n'

      action = gets.chomp.downcase

      case action
      when '1'  then pet.info
      when '2'  then pet.play
      when '3'  then pet.water
      when '4'  then pet.feed
      when '5'  then pet.sleep
      when '6'  then pet.vet
      when '7'  then pet.train
      when '8'  then pet.hunt
      when '9'  then pet.wash
      when '10' then pet.toilet
      when '11' then pet.kill
      when 'q'  then exit
      else
        action
      end
    end
  end

  def html
    body = "
    <div>
      <p>Жизни: #{@pet.life}</p>
      <p>Настроение: #{@pet.mood}</p>
      <p>Кл-во воды: #{@pet.water_lvl}</p>
      <p>Голод: #{@pet.feed_lvl}</p>
      <p>Энергия: #{@pet.energy_lvl}</p>
      <p>Нуждается во сне: #{@pet.need_sleep}</p>
      <p>Нужно к ветеринару: #{@pet.need_vet}</p>
    </div>"

    GetSaveGem.new.get(body, true)
  end
end
