class GroupSets::AppliedStatusesController < ApplicationController
  def update
    @group_set = GroupSet.find(params[:group_set_id])
    params[:cancel_update] ? CancelUpdateMatchingScoresService.call(@group_set) :
                             UpdateMatchingScoresService.call(@group_set)
    redirect_to group_sets_path
  end
end
