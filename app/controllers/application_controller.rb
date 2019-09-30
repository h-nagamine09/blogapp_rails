class ApplicationController < ActionController::Base
  private def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end
  helper_method :current_member #ヘルパーメソッドとして登録

  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

if Rails.env.production? || ENV["RESCUE_EXEPTIONS"]
  rescue_from StandardError, with: :rescue_internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
  rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
end

  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden


  private def login_required
    raise LoginRequired unless current_member
  end

#例外発生に対するメソッド
  private def rescue_bad_request(exeption)
    render "errors/bad_request", status: 400,layout: "error",
    formats: [:html]
  end
  private def rescue_login_required(exeption)
    render "errors/login_required", status: 403,layout: "error",
    formats: [:html]
  end

  private def rescue_forbidden(exeption)
    render "errors/forbidden", status: 403,layout: "error",
    formats: [:html]
  end

  private def rescue_not_found(exeption)
    render "errors/not_found", status: 404,layout: "error",
    formats: [:html]
  end

  private def rescue_internal_server_error(exeption)
    render "errors/internal_server_error", status: 500,layout: "error",
    formats: [:html]
  end
end

# 400 Bad Request リクエストの構文、形式、内容が正しくない
# 403 Forbidden リソースへのアクセス権がない
# 404 Not Found リソースが存在しない
# 500 Internal Server Error アプリケーションでエラーが発生した
