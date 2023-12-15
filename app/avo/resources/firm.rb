class Avo::Resources::Firm < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :description, as: :textarea
    field :address, as: :text
    field :phone_number, as: :text
    field :email, as: :text
    field :fb_page, as: :text
    field :category_id, as: :number
    field :status, as: :select, enum: ::Firm.statuses
    field :user_id, as: :number
    field :tags, as: :text
    field :category, as: :belongs_to
    field :user, as: :belongs_to
  end
end
