class Ping
  attr_accessor :session_id, :status

  def initialize *args
  end

  def ownable?
    false
  end

  def attributes= attributes
    attributes[:status] == 'start'
      ActivityTime
  end

  def save
    true
  end
end
