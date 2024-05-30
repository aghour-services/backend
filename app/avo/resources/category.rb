class Avo::Resources::Category < Avo::BaseResource
  self.default_view_type = :grid
  self.includes = [:firms]
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  self.grid_view = {
    card: lambda {
      {
        cover_url: record&.icon_path,
        title: record&.name,
        body: "#{record&.firms&.count} firms"
      }
    }
  }

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