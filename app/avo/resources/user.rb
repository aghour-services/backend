class Avo::Resources::User < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    main_panel do
      field :id, as: :id
      field :avatar, as: :external_image, link_to_resource: true, as_avatar: :circle, width: 60, height: 60,
                     radius: 60, only_on: :index do
        record&.avatar&.url
      end
      field :name, as: :text
      field :mobile, as: :text
      field :email, as: :text, protocol: :mailto
      field :token, as: :text, hide_on: :all
      field :role, as: :select, enum: ::User.roles, hide_on: %i[index show]

      sidebar do
        field :avatar, as: :external_image, link_to_resource: true, as_avatar: :circle,
                       width: 60, height: 60, radius: 60 do
          record&.avatar&.url
        end
        field :admin, as: :boolean, only_on: %i[index show] do
          record&.role == 'admin'
        end
      end
    end

    field :articles, as: :has_many
    field :firms, as: :has_many
    field :comments, as: :has_many
    field :likes, as: :has_many
    field :devices, as: :has_many
    field :notifications, as: :has_many
  end
end
