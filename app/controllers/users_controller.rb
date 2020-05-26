class UsersController < ApplicationController
  def top
    @users = User.all.shuffle.first(3)
    @propositions = Proposition.all.shuffle.first(4)
  end

  def index
    # 退会していないユーザーのみ表示。
    @users = User.where(user_status: "subscribing").page(params[:page]).per(8).reverse_order
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
