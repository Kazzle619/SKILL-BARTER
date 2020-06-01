class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.proposition_id = params[:proposition_id].to_i
    if @comment.save
      redirect_to proposition_path(params[:proposition_id].to_i)
    else
      @proposition = Proposition.find(params[:proposition_id])
      if @proposition.offering_to?
        @offering_proposition = @proposition.my_offering_proposition
        @offer = @offering_proposition.offering_relationship
      end
      @comments = @proposition.comments
      @user = @proposition.user
      render 'propositions/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    redirect_to proposition_path(params[:proposition_id].to_i)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end
end
