class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.proposition_id = params[:proposition_id].to_i
    if @comment.save
      redirect_to proposition_path(params[:proposition_id])
    else
      @proposition = Proposition.find(params[:proposition_id])
      if @proposition.offer.exists?
        @offer = @proposition.offer
        @offering_proposition = Proposition.find(@offer.offering_id)
      end
      @comments = @proposition.comments
      @user = @proposition.user
      render 'propositions/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to proposition_path(params[:proposition_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end
end
