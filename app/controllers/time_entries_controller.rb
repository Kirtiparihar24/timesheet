class TimeEntriesController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :time_entry, through: :user

  def index
    @time_entries = @time_entries.order(clock_in: :desc).complete
    @active_timer = TimeEntry.active_timer(@user.id).first
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to user_time_entries_path(@user), notice: "Time Slot was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @time_entry.update(time_entry_params)
        format.html { redirect_to user_time_entries_path(@user), notice: "Time Slot was successfully updated." }
        format.json { render :show, status: :ok, location: @time_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @time_entry.destroy
    respond_to do |format|
      format.html { redirect_to user_time_entries_path(@user), notice: "Time Slot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def time_entry_params
      params.require(:time_entry).permit(:clock_in, :clock_out, :detail)
    end
end
