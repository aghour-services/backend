class Avo::Resources::Notification < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :title, as: :text
    field :body, as: :textarea
    field :notifiable_type, as: :text
    field :notifiable_id, as: :number
    field :image_url, as: :text
    field :user_id, as: :number
    field :notifiable, as: :belongs_to, polymorphic_as: :notifiable, types: [::Article, ::Comment]
    field :user, as: :belongs_to
  end
end
