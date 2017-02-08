class GraphqlController < ApplicationController
  def execute
    query_string = params[:query]
    variables = ensure_hash(params[:variables])
    result = ::Graph::Schema.execute(query_string, variables: variables)
    render json: result
  end

  private

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
