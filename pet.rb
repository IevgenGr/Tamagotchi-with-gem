# frozen_string_literal: true

class Pet
  attr_accessor :pet,
                :name,
                :life,
                :feed_lvl,
                :water_lvl,
                :energy_lvl,
                :mood,
                :need_vet,
                :need_sleep

  def initialize(name = 'Oleg')
    @pet        = 'Лев'
    @name       = name
    @life       = 3
    @feed_lvl   = 3
    @water_lvl  = 3
    @energy_lvl = 3
    @mood       = 'Доволен'
    @need_vet   = false
    @need_sleep = false

    puts "#{@pet} #{@name} родился \n"
  end

  # Animal indicators
  def info
    puts 'Информация о питомце: ',
         "  Животное:                     #{@pet}",
         "  Имя животного:                #{@name}",
         "  Жизни животного:              #{@life}",
         "  Кл-во воды животного:         #{@water_lvl}",
         "  Голод животного:              #{@feed_lvl}",
         "  Энергия животного:            #{@energy_lvl}",
         "  Настроение животного:         #{@mood}",
         "  Животное нуждается во сне:    #{@need_sleep}",
         "  Животному нужно к ветеринару: #{@need_vet} \n"
  end

  # Play with animal
  def play
    @mood        = 'Счастлив'
    @energy_lvl -= 1

    puts 'Вы играете со своим питомцем.',
         "Питомец #{@mood}.",
         '*Ваш питомец устал',
         '*Ваш питомец голоден',
         '*Ваш питомец хочет пить \n'
    check
    passage_of_time
  end

  # Feed your animal
  def feed
    if @feed_lvl <= 2
      @mood      = 'Доволен'
      @feed_lvl += 1

      puts 'Хрум-хрум. Вкусно то как!'
      puts 'Я не наелся, хочу ещё!' if @feed_lvl < 3
      puts 'Ваш питомец сыт \n'
    else
      puts 'Я не голоден! \n'
    end
  end

  # Water your animal

  def water
    if @water_lvl <= 2
      @mood       = 'Доволен'
      @water_lvl += 1

      puts 'Ваш питомец выпил воды'
      puts 'Бульк-бульк. водииичка!'
      puts 'Я не напился, хочу ещё! \n' if @feed_lvl < 3
    else
      puts 'Я не хочу пить! \n'
    end
  end

  # Put your animal to sleep
  def sleep
    @mood       = 'Сонный'
    @energy_lvl = 3

    puts 'Ваш питомец спит',
         'юхххррррр.... ххрррррююююю....'

    temp = rand(2)
    if temp.zero?
      @energy_lvl = 1

      puts 'Ваш питомец неожиданно проснулся',
           'ррррр',
           'Ему приснилось нечто ужасное',
           'гргргрррр грр',
           'В ужасе бегает по комнате и рычит',
           'гррр ггргрррр \n'
    else
      puts 'Ваш питомец выспался',
           'Ура! Теперь я полон сил! \n'
    end
    passage_of_time
  end

  # Go to the vet
  def vet
    if @life < 3
      @mood       = 'Счастлив'
      @life       = 3
      @feed_lvl   = 3
      @water_lvl  = 3
      @energy_lvl = 3

      puts 'Вы пошли к ветеринару',
           'Ну вот, тепкрь всё будет хорошо! \n'
    else
      puts 'Вам не нужно к ветеринару \n'
    end
    passage_of_time
    check
  end

  def train
    @energy_lvl = 1
    @feed_lvl   = 1
    @water_lvl  = 1
    @mood       = 'Злой'
    puts 'Вы отдали питомца на дрессировку',
         'ррррр',
         '*бегает и выполняет команды \n'
    passage_of_time
    check
  end

  def hunt
    @water_lvl  = 2
    @energy_lvl = 1
    @feed_lvl   = 2
    @mood       = 'Уставший'
    puts 'Вы идёте на охоту за кабанами',
         'РРРРррРРрр',
         'Побежал за кабаном',
         'Кабан убежал',
         'Вы возвращаетесь домой \n'
    passage_of_time
    check
  end

  def wash
    @need_sleep = true
    @mood       = 'Довольный'
    puts 'Вы моете питомца',
         'рррРрррРРРр \n'
    passage_of_time
    check
  end

  def toilet
    @water_lvl = 1
    @feed_lvl  = 1
    puts 'Пошёл в туалет \n'
    passage_of_time
    check
  end

  def kill
    puts 'Питомец одичал и напал на вас!',
         'Кстати, вы мертвы :)'
    exit
  end

  private

  def dead?
    exit if @life.zero?
  end

  def need_sleep?
    @need_sleep = true if @energy_lvl != 3
  end

  def need_vet?
    @need_vet = true if @life != 3
  end

  # Maybe take one life?
  def check
    need_sleep?
    need_vet?
    if @water_lvl < 1 || @feed_lvl < 1 || @energy_lvl < 1
      if @water_lvl.negative? || @feed_lvl.negative? || @energy_lvl.negative?
        @water_lvl = 3
        @feed_lvl = 3
        @energy_lvl = 3
      end
      @mood = 'Разочарован'
      @life -= 1

      puts 'Вы плохо следите за питомцем',
           "У питомца осталось #{@life} жизни \n"
    end
  end

  # Passage of time
  def passage_of_time
    if @water_lvl || @feed_lvl >= 1
      @feed_lvl  -= rand(2)
      @water_lvl -= rand(2)
    else
      puts 'Вы только вышли из дома, а питомец уже устал... \n'
    end
  end
end

puts 'Дейте имя питомцу:'
name = gets.chomp.capitalize
pet = Pet.new name

while  pet.life.positive?
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
