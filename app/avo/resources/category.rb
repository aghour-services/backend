class Avo::Resources::Category < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :icon, as: :file, accept: 'image/*', hide_on: :index
    field :icon_path, as: :external_image, link_to_resource: true,
                      width: 110, height: 110, radius: 8, only_on: :index do
      record&.icon_path
    end
    field :firms, as: :has_many
  end
end
