class Avo::Resources::Notification < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :title, as: :text
    field :body, as: :textarea
    field :image, as: :external_image, width: 90, height: 90, radius: 8 do
      record&.image_url
    end
    field :notifiable, as: :belongs_to, polymorphic_as: :notifiable, types: [::Article, ::Comment]
    field :user, as: :belongs_to
  end
end