require 'travis/api/v3/access_control/generic'

module Travis::API::V3
  class AccessControl::Scoped < AccessControl::Generic
    attr_accessor :unscoped, :owner_name, :name

    def initialize(scope, unscoped)
      @owner_name, @name = scope.split(?/.freeze, 2)
      @unscoped          = unscoped
    end

    protected

    def private_repository_visible?(repository)
      return false if name and repository.name != name
      unscoped.visible?(repository) if repository.owner_name == owner_name
    end
  end
end
