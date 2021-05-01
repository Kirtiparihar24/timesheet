class StopTimersController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :time_entry, instance_name: :current_timer, through: :user

  def update
    @current_timer.update(clock_out: Time.zone.now)
    
    redirect_to user_time_entries_path(@user)
  end

end