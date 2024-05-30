class Avo::Resources::Comment < Avo::BaseResource	
  self.includes = []	
  # self.search = {	
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }	
  # }	

  def fields	
    field :id, as: :id	
    field :body, as: :text	
    field :user, as: :belongs_to	
    field :article, as: :belongs_to	
    field :notifications, as: :has_many	
  end	
end	
