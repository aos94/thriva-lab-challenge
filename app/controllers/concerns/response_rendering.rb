module ResponseRendering
  def json_response(response_body, response_status = :ok)
    render json: response_body, status: response_status
  end

  def error_response(errors, response_status)
    json_response({ errors: errors }, response_status)
  end

  def render_invalid_includes_error(invalid_includes)
    errors = invalid_includes.map do |invalid_include|
      {
        source: { parameter: :include },
        title: "Invalid Query Parameter",
        detail: "`#{invalid_include}` is not a valid relationship for the requested resource"
      }
    end

    error_response(errors, :bad_request)
  end

  def render_not_found_error
    error_response([ { title: "Resource not found"} ], :not_found)
  end
end
