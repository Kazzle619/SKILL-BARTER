class PropositionsController < ApplicationController
  def index
    @propositions = Proposition.page(params[:page]).per(8).reverse_order
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def mypage_index
  end

  def offer
  end

  def search
  end

  def finish
  end

  def match
  end
end
