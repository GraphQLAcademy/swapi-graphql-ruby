class GraphqlController < ApplicationController
  before_action :authenticate

  def execute
    query_string = params[:query].to_s
    variables = ensure_hash(params[:variables])
    context = { user: @user }

    result = Graph::Schema.execute(query_string, variables: variables, context: context)
    render json: result
  end

  private

  def authenticate
    @user = authenticate_with_http_basic { |username, password|
      user = User.where(username: username).first

      return unless user
      return unless user.authenticate(password)

      user
    }
  end

  def ensure_hash(variables)
    if variables.blank?
      {}
    elsif variables.is_a?(String)
      JSON.parse(variables)
    else
      variables
    end
  end
end
