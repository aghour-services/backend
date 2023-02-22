module Api
    class CommentsController < ApiController
        before_action :authenticate_user!, only: %i[create update destroy]
        before_action :find_article
        before_action :find_comment, only: %i[update destroy]

        def index
            @comments = @article.comments
        end

        def create
            @comment = @article.comments.new(comment_params.merge(user: current_user))
            if @comment.save
                render :create, status: :created
            end
        end

        def update
            if @comment.user == current_user
                if @comment.update(comment_params)
                   render :update, status: :ok
                end
            end
        end

        def destroy
            if @comment.user == current_user
                if @comment.destroy
                    head :no_content
                end
            end
        end
       
        private
        
        def comment_params
            params.require(:comment).permit(:body)
        end

        def find_article
            @article = Article.find(params[:article_id])
        end

        def find_comment
            @comment = @article.comments.find(params[:id])
        end
    end
end