class LunchesController < ApplicationController
  before_action :load_resource

  def index; end

  def show; end

  def new; end

  def create
    lunch = ShuffleService.call(@users, params[:group_num].to_i)
    lunch.save_with_groups
    redirect_to lunch_path(lunch)
  end

  def destroy
    if @lunch.groups.map(&:delete) && @lunch.destroy
      redirect_to lunches_path, flash: { notice: "チーム分けの削除に成功しました!" }
    else
      redirect_to lunches_path, flash: { error: "チーム分けの削除に失敗しました!" }
    end
  end

  private
    def load_resource
      case params[:action].to_sym
      when :index
        @lunches = Lunch.all.desc(:created_at).page(params[:page]).per(10)
      when :show
        @lunch = Lunch.find(params[:id])
        @groups = @lunch.groups
      when :new
        @users = User.active
      when :create
        @users = User.where(:id.in => params[:user_ids])
      when :destroy
        @lunch = Lunch.find(params[:id])
      end
    end
end
