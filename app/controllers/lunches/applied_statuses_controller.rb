class Lunches::AppliedStatusesController < ApplicationController
  def update
    @lunch = Lunch.find(params[:lunch_id])
    params[:cancel_update] ? CancelUpdateMatchingScoresService.call(@lunch) :
                             UpdateMatchingScoresService.call(@lunch)
    redirect_to lunches_path
  end
end
