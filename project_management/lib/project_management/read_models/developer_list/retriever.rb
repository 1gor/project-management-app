module ProjectManagement
  class DeveloperList::Retriever
    def retrieve
      @state = reply_state
      self
    end

    def developers
      @state.developers
    end

    def exists?(developer_uuid)
      @state.developers.any? { |developer| developer[:uuid] == developer_uuid }
    end

    def email_taken?(email)
      @state.developers.any? { |developer| developer[:email] == email }
    end

    private

    def initialize(event_store:)
      @event_store = event_store
    end

    def reply_state
      all_events_in(stream_name).each_with_object(DeveloperList::State.new) do |event, state|
        state.reply(event)
      end
    end

    def all_events_in(stream_name)
      @event_store.read.stream(stream_name).each.to_a
    end

    def stream_name
      'ProjectManagement::DeveloperListReadModel'
    end
  end
end
