class UsersController < ApplicationController
  load_and_authorize_resource :user

  before_action :authorize_admin, except: :show

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    # @user.password = Devise.friendly_token.first(8)
    @user = User.new(user_params.merge(password: "Test1234"))
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def authorize_admin
      return unless !current_user.admin?
      redirect_to root_path, alert: 'Admins only!'
    end
end
