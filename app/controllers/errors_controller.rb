class ErrorsController < ApplicationController
  layout "eror"

  def show
    ex = request.env["action_dispatch.exception"]

    if ex.kind_of?(ActionController::RoutingError)
      render "not_found", status: 404,formats: [:html]
    else
      render "internal_sserver_error",status: 500, formats: [:html]
    end
  end
end