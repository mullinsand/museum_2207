class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.select do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    interest_hash = Hash.new{|h, k| h[k] = []}
    exhibits.each do |exhibit|
      interest_hash[exhibit] = patrons.select do |patron|
        patron.interests.include?(exhibit.name)
      end
    end
    interest_hash
  end

  def ticket_lottery_contestants(exhibit)
    contestants = patrons_by_exhibit_interest[exhibit].select do |patron|
      patron.spending_money < exhibit.cost
    end
    contestants
  end

  def draw_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit) != []
    ticket_lottery_contestants(exhibit).sample.name
    else
      nil
    end
  end

  def announce_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit) != []
      "#{draw_lottery_winner(exhibit)} has won tickets to see the #{exhibit.name} exhibit!"
    else
      "No winners for this lottery"
    end
  end
end
