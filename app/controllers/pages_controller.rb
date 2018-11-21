class PagesController < ApplicationController

  def welcome
    redirect_to shortened_urls_path and return if current_user
  end

  def redirect
    target_url = ShortenedUrl.lookup_target_url_by_short_path(params[:short_path], request.base_url)
    if target_url
      redirect_to target_url
    else
      render :cannot_redirect
    end
    return
  end

  def cannot_redirect
  end

end
