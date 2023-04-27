class EntitiesController < ApplicationController
  def index
    @group_id = params[:group_id].to_i
    @entities = Entity.where(author_id: current_user.id).order(created_at: :desc)
    @current_group_entities = []
    @total_amount = 0

    @entities.each do |entity|
      @groups_array = entity.groups.to_a
      @groups_array.each do |group|
        if group.id == @group_id
          @current_group_entities << entity
          @total_amount += entity.amount
        end
      end
    end
  end

  def new
    @entity = Entity.new
    @groups = current_user.groups
  end

  def create
    entity_params_with_groups = entity_params
    entity_params_with_groups[:groups] = Group.where(id: entity_params[:groups])

    @entity = Entity.new(entity_params_with_groups)
    @entity.author = current_user

    respond_to do |format|
      if @entity.save
        format.html { redirect_to root_path }
      else
        p '***********************'
        p @entity.errors.full_messages
        p '***********************'
        format.html { render :new }
      end
    end
  end

  def entity_params
    params.require(:entity).permit(:name, :amount, groups: [])
  end
end
