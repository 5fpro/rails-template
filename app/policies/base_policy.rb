class BasePolicy < ::Tyr::BasePolicy
  def index?
    true
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def edit?
    index?
  end

  def new?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
