class Avo::Resources::Firm < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    main_panel do
      field :id, as: :id
      field :name, as: :text
      field :description, as: :textarea
      field :address, as: :text
      field :phone_number, as: :text
      field :status, as: :select, enum: ::Firm.statuses, hide_on: %i[index show]
      field :status, as: :badge, enum: ::Firm.statuses, only_on: %i[index show],
                    options: {
                      success: :published,
                      warning: :draft
                    }, sortable: true

      field :category, as: :text do
        record&.category&.name
      end
      field :user, as: :text do
        record&.user&.name
      end
    end

    field :category, as: :belongs_to
    field :user, as: :belongs_to
  end
end
