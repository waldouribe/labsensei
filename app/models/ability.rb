class Ability
  include CanCan::Ability

  def initialize(user) 
    # Guest user (not logged in)
    user ||= User.new

    if user.role? :god
      can :manage, :all
    else

      if user.role?(:admin) || user.role?(:member)
        can :manage, Import
      end

      if user.role? :admin
        if user.institution.plan.id > 2
          can [:index, :edit, :update], User do |u|
            u.institution_id == user.institution_id
          end
        end
      end

      can [:read, :index, :search], Patient do |patient|
        patient.institution_id == user.institution_id
      end

      can [:read], Institution do |institution|
        institution.id == user.institution_id
      end

      can [:edit, :update], User do |u|
        u.id == user.id
      end

      if !user.role || user.role?(:pending)
        cannot :manage, [Patient]
      end
    end
  end
end
