class LikesController < HtmlController

  def create
    @like = Like.new(article_id: params[:article_id], user_id: current_user.id)
    if @like.save
      redirect_to @like.article
    end
  end
end
