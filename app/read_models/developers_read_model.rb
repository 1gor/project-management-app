class DevelopersReadModel
  def handle(event)
    case event
      when ProjectManagement::DeveloperRegistered
        create_developer(
          event.data[:uuid],
          event.data[:fullname],
          event.data[:email]
        )
    end
  end

  def all
    ::Developer.all
  end

  def find(uuid)
    ::Developer.find(uuid)
  end

  private

  def create_developer(uuid, fullname, email)
    ::Developer.create!(
      uuid:     uuid,
      fullname: fullname,
      email:    email
    )
  end
end