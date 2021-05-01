class StartTimersController < ApplicationController
  load_and_authorize_resource :user

  def create
    @user.time_entries.create(clock_in: Time.zone.now)

    redirect_to user_time_entries_path(@user)
  end

end