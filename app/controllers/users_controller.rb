class UsersController < ApplicationController
	before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    #index
    def index
    	@users = User.all
    end

    #create
    def create 
    	@user = User.new(permit_params)
    	result = @user.save
    	respond_to do |format|
	        if result
	          format.html { redirect_to users_url, notice: 'User was successfully created.' }
	          format.json { render :show, status: :created, location: users_url }
	        else
	          format.html { render :new }
	          format.json { render json: @user.errors, status: :unprocessable_entity }
	        end
      end
    end 

    protected 

    def permit_params
    	params.require(:user).permit!#(User.column_names - ["created_at", "updated_at"])
    end
end
