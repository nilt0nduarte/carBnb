class CarPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def global_search
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def edit?
    return update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
