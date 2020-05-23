class UsersController < ApplicationController
  def top
    @users = User.all.shuffle.first(3)
    @propositions = Proposition.all.shuffle.first(4)
  end

  def index
  end

  def mypage
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def blocking
  end

  def followers
  end

  def following
  end

  def notice
  end
end
