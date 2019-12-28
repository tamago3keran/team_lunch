class UpdateMatchingScoresService < BaseService
  def initialize(lunch)
    @lunch = lunch
  end

  def call
    @lunch.groups.each do |group|
      group.members.each do |member|
        member.matching_score_set.update_scores_by_matching!(group.partners(member))
        member.matching_score_set.update_scores_by_unmatching!(group.other_groups_users)
      end
    end
    @lunch.applied = true
    @lunch.save
  end
end
