class Lunches::GroupsController < ApplicationController
  before_action :load_resource

  def new; end

  def create
    @group = Group.new(lunch: @lunch, member_ids: params[:user_ids])
    if @group.save
      redirect_to lunch_path(@lunch), flash: { notice: "チーム作成に成功しました!" }
    else
      redirect_to lunch_path(@lunch), flash: { error: "チーム作成に失敗しました!" }
    end
  end

  def edit; end

  def update
    if @group.update_attributes(member_ids: params[:user_ids])
      redirect_to lunch_path(@lunch), flash: { notice: "チーム更新に成功しました!" }
    else
      redirect_to lunch_path(@lunch), flash: { error: "チーム更新に失敗しました!" }
    end
  end

  def destroy
    return redirect_to lunch_path(@lunch), flash: { error: "チーム削除に失敗しました!" } if @group.blank?
    if @group.delete
      redirect_to lunch_path(@lunch), flash: { notice: "チーム削除に成功しました!" }
    else
      redirect_to lunch_path(@lunch), flash: { error: "チーム削除に失敗しました!" }
    end
  end

  private
    def load_resource
      case params[:action].to_sym
      when :new
        @group = Group.new
        @lunch = Lunch.find(params[:lunch_id])
        @users = User.active
      when :create
        @lunch = Lunch.find(params[:lunch_id])
      when :edit
        @group = Group.find(params[:id])
        @lunch = @group.lunch
        @users = User.active
      when :update
        @lunch = Lunch.find(params[:lunch_id])
        @group = @lunch.groups.find(params[:id])
      when :destroy
        @lunch = Lunch.find(params[:lunch_id])
        @group = @lunch.groups.find(params[:id])
      end
    end
end
