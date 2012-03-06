class Ability
  include Mongoid::Document
  include CanCan::Ability  
    
  def initialize(user)
    @user = user || User.new # for guest
    @user.roles.each { |role| send(role.name) }

    if @user.roles.size == 0
      can :read, :all #for guest without roles    
    end

  end

  def attender
    can :read, :all
    can :update, User do |user|
        user.try(:id) == @user.id
    end
  end
  
  def member
    attender
  
  end
  
  def mtl
    member
  
  end
  
  def cgl
    member
  
  end
    
  def elder_candidate
    member
  
  end
  
  def elder
    member
    can :manage, User
  end

  def admin
    can :manage, :all
  end
end
