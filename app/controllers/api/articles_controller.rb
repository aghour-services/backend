# frozen_string_literal: true

module Api
  class ArticlesController < ApiController
    CACHE_KEY = 'articles#index'

    before_action :authenticate_user, only: %i[index]
    before_action :authenticate_user!, only: %i[create update destroy]
    before_action :user_ability, only: %i[create update destroy show]
    before_action :find_article, only: %i[update destroy show]

    # after_action :cache_response, only: [:index]
    # before_action :check_cached, only: [:index]

    def index
      # if @cached_response
      #   render json: @cached_response
      #   return
      # end
      @articles = Article.includes(:user, :comments, :likes).published.order(id: :desc).first(50)
      @current_user = current_user
    end

    def show; end

    def draft
      @articles = Article.includes(:user, :comments, :likes).draft.order(id: :desc)
      @current_user = current_user
    end

    def create
      ActiveRecord::Base.transaction do
        @resource = Article.new(article_params.merge(user: current_user))
        @resource.status = :published if user_ability.can_publish?

        begin
          if @resource.save!
            upload_image
            render :create, status: :created
          end
        rescue StandardError
          render json: { errors: @resource.errors.messages }, status: :unprocessable_entity
          raise ActiveRecord::Rollback
        end
      end
    end

    def update
      return unauthorized_user unless user_ability.can_update?

      if @resource.update(article_params)
        @resource.attachments.destroy_all
        @resource.status = :published if user_ability.can_publish?
        upload_image
        render :update, status: :ok
      else
        render json: { error: @resource.errors.messages }, status: :unprocessable_entity
      end
    end

    def unauthorized_user
      render json: { error: 'You can only edit your own articles' }, status: :unauthorized
    end

    def destroy
      if user_ability.can_destroy?
        head :no_content if @resource.destroy
      else
        render json: { error: 'You can only delete your own articles' }, status: :unauthorized
      end
    end

    private

    def find_article
      @resource = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:description, :status)
    end

    def upload_image
      if params[:article][:attachment].present?
        response = ImgurUploader.upload(params[:article][:attachment].tempfile.path)
        raise StandardError, 'خطأ في تحميل الصورة' unless response['success'] == true

        resource_id = response['data']['id']
        resource_type = response['data']['type']
        attachment = AttachmentRepo.new(@resource, response, resource_id, resource_type)
        attachment.create_attachment
      end
    end
  end
end
