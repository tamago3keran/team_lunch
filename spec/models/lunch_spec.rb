require "rails_helper"

describe Lunch do
  let(:lunch) { Lunch.new }
  let!(:group1) { Group.new(lunch: lunch) }
  let!(:group2) { Group.new(lunch: lunch) }

  describe "#save_with_groups" do
    before { lunch.save_with_groups }

    it "saves lunch and groups" do
      expect(Lunch.all.count).to eq 1
      expect(Group.all.count).to eq 2
    end
  end

  describe "#total_matching_score" do
    before do
      allow(lunch).to receive(:groups).and_return([group1, group2])
      allow(group1).to receive(:matching_score).and_return(1.0)
      allow(group2).to receive(:matching_score).and_return(1.0)
    end

    it "returns sum of group matching_scores" do
      expect(lunch.total_matching_score).to eq 2.0
    end
  end
end
