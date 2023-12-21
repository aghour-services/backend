class Avo::Resources::Device < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :token, as: :text
    field :last_usage_time, as: :date_time
    field :user_id, as: :number
    field :user, as: :belongs_to
  end
end
