class Me

  def initialize controller
    @controller = controller
  end

  def as_json(*args)
    @controller.send(:current_user).as_json(*args)
  end
end
