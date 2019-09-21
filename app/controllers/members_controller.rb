class MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_member, only: %i[edit update destroy]

  def index
    @members = current_admin.members.paginate(page: params[:page])
  end

  def new
    @member = current_admin.members.build
  end

  def create
    @member = current_admin.members.build(member_params)

    if @member.save
      flash[:success] = t('.success')
      redirect_to members_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @member.update(member_params)
      flash[:success] = t('.success')
      redirect_to members_path
    else
      render :edit
    end
  end

  def destroy
    @member.destroy

    flash[:success] = t('.success')
    redirect_to members_path
  end

  private

  def set_member
    @member = current_admin.members.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :email)
  end
end