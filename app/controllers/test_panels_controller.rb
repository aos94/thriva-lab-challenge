class TestPanelsController < ApplicationController
  include ResponseRendering

  def show
    includes = Array(params[:include].try(:split, ","))

    invalid_includes = includes.
      reject { |relation_name| Relations.exists_for?(TestPanel, relation_name) }

    return render_invalid_includes_error(invalid_includes) if invalid_includes.any?

    test_panel = TestPanel.find(params[:id])

    return render_not_found_error if test_panel.nil?

    json_response ResponseItem.new(resource: test_panel, includes: includes).call
  end
end
