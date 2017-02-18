class GraphqlController < ApplicationController
  GRAPHQL_TIMEOUT = 10

  before_action :authenticate

  def execute
    query_string = params[:query].to_s
    variables = ensure_hash(params[:variables])
    context = { user: @user }

    result = Graph.query(
      query_string,
      variables: variables,
      context: context,
      timeout: GRAPHQL_TIMEOUT
    )

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
