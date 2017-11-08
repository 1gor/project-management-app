require 'aggregate_root'

module Assignments
  class Project
    include AggregateRoot

    def initialize(uuid)
      @uuid       = uuid
      @developers = []
    end

    def register(name)
      apply(Assignments::ProjectRegistered.new(data: {
        uuid: @uuid,
        name: name
      }))
    end

    def estimate(hours)
      apply(Assignments::ProjectEstimated.new(data: {
        uuid:  @uuid,
        hours: hours
      }))
    end

    def assign_developer(uuid, fullname)
      apply(Assignments::DeveloperAssignedToProject.new(data: {
        project_uuid:       @uuid,
        developer_uuid:     uuid,
        developer_fullname: fullname
      }))
    end

    private

    def apply_project_registered(event)
    end

    def apply_project_estimated(event)
    end

    def apply_developer_assigned_to_project(event)
      @developers << {
        uuid:     event.data[:developer_uuid],
        fullname: event.data[:developer_fullname]
      }
    end
  end
end
