class Avo::Resources::Like < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :article_id, as: :number
    field :user, as: :belongs_to
    field :article, as: :belongs_to
  end
end
