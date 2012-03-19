class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to topics_path
    end
  end
end
