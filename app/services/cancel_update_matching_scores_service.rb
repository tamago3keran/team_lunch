class CancelUpdateMatchingScoresService < BaseService
  def initialize(lunch)
    @lunch = lunch
  end

  def call
    @lunch.groups.each do |group|
      group.members.each do |member|
        member.matching_score_set.cancel_update_scores_by_matching!(group.partners(member))
        member.matching_score_set.cancel_update_scores_by_unmatching!(group.other_groups_users)
      end
    end
    @lunch.applied = false
    @lunch.save
  end
end
