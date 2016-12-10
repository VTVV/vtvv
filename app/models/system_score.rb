class SystemScore < ApplicationRecord

  monetize :score_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}

  def self.instance
    first or create
  end

  def self.create
    nil
  end

  def self.new
    nil
  end

end
