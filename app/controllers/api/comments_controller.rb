module Api
    class CommentsController < ApiController
        before_action :authenticate_user!, only: %i[create update destroy]
        before_action :find_article

        def index
            @comments = @article.comments
        end

        def create
            @comment = @article.comments.new(comment_params.merge(user: current_user))
            if @comment.save
                render :create, status: :created
            else
                render json: @comment.errors
            end
        end

        def update
            @comment = @article.comments.find(params[:id])
            if @comment.user == current_user
               render update, if @comment.update(comment_params)
            else
                render json: { error: 'You can only edit your own comments' }
            end
        end
       
        private
        
        def comment_params
            params.require(:comment).permit(:body)
        end

        def find_article
            @article = Article.find(params[:article_id])
        end
    end
end