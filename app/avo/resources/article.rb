class Avo::Resources::Article < Avo::BaseResource
  self.includes = %i[user comments likes attachments notifications]

  self.search = {
    query: lambda {
             query.ransack(id_eq: params[:q], description_cont: params[:q], user_name_cont: params[:q],
                           m: 'or').result(distinct: false)
           },
    item: lambda {
      {
        title: record.description
      }
    }
  }

  self.grid_view = {
    card: lambda {
      {
        cover_url: record&.attachments&.last&.resource_url,
        title: record&.description,
        body: record&.status
      }
    }
  }

  def fields
    main_panel do
      field :id, as: :id
      field :description, as: :textarea, row: 5, hide_on: %i[index show]
      field :attachments, as: :external_image, width: 90, height: 90, radius: 8 do
        record&.attachments&.last&.resource_url
      end
      field :description, as: :text, required: true, readonly: true, as_html: true,
                          format_using: -> { record.description.truncate(60) },
                          hide_on: %i[new edit show]
      field :description, as: :text, required: true, readonly: true, as_html: true,
                          hide_on: %i[new edit index]
      field :status, as: :select, enum: ::Article.statuses, hide_on: %i[index show]
      field :status, as: :badge, enum: ::Article.statuses, only_on: %i[index show],
                     options: {
                       success: :published,
                       warning: :draft
                     }, sortable: true
    end

    field :user, as: :belongs_to
    field :comments, as: :has_many
    field :likes, as: :has_many
    # field :attachments, as: :has_many
    field :notifications, as: :has_many
  end
end
