class GroupsController < ApplicationController
    def index
        @groups = current_user.groups
    end
    
    def new
        @group = Group.new
    end

    def create
        @group = current_user.groups.new(group_params)
        @group.user = current_user

        respond_to do |format|
            if @group.save
                format.html { redirect_to root_path }
            else
                format.html { render :new }
            end
        end
    end

    def group_params
        params.require(:group).permit(:name, :icon)
    end
end
