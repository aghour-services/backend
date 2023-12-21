class Avo::Resources::Article < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :description, as: :textarea, row: 5, hide_on: %i[index show]
    field :attachments, as: :external_image, width: 90, height: 90, radius: 8 do
      'https://i.imgur.com/0U41ISJ.png'
    end
    field :description, as: :text, required: true, readonly: true, as_html: true,
                        format_using: -> { record.description.truncate(40) },
                        hide_on: %i[new edit]
    field :status, as: :select, enum: ::Article.statuses, hide_on: %i[index show]
    field :status, as: :badge, enum: ::Article.statuses, only_on: %i[index show],
                   options: {
                     success: :published,
                     warning: :draft
                   }
    field :user, as: :belongs_to
    field :comments, as: :has_many
    field :likes, as: :has_many
    # field :attachments, as: :has_many
    field :notifications, as: :has_many
  end
end
