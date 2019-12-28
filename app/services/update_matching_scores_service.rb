class UpdateMatchingScoresService < BaseService
  def initialize(group_set)
    @group_set = group_set
  end

  def call
    @group_set.groups.each do |group|
      group.members.each do |member|
        member.matching_score_set.update_scores_by_matching!(group.partners(member))
        member.matching_score_set.update_scores_by_unmatching!(group.other_groups_users)
      end
    end
    @group_set.applied = true
    @group_set.save
  end
end
