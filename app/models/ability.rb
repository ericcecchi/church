class Ability
  include Mongoid::Document
  include CanCan::Ability  
    
  def initialize(user)
    @user = user || User.new # for guest

    if @user.role.nil?
      can :read, :all #for guest without roles
    else
	    send @user.role 
    end

  end

  def attender
    can :read, :all
    can :update, User do |user|
        user.try(:id) == @user.id
    end
  end
    
  def leader
    attender
  end

  def elder
    leader
  end

  def admin
    can :manage, :all
  end
end
