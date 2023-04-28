class GroupsController < ApplicationController
  def index
    @groups = Group.includes([:entities]).where(user_id: current_user.id)
    @totals = []

    @groups.each_with_index do |group, index|
      @totals[index] = 0
      group.entities.each do |entity|
        @totals[index] += entity.amount
      end
    end
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
