class AuxController < ApplicationController
  skip_before_action :authenticate_user!, only: [:splash]

  def splash
    return unless user_signed_in?

    redirect_to groups_path
  end
end
