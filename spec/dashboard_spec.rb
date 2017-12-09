require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts visible to the current user" do
      user          = create(:user)
      visible_posts = double("visible_posts")
      dashboard     = Dashboard.new(posts: Post.all, user: user)

      allow(Post).to receive(:visible_to).with(user).and_return(visible_posts)

      expect(dashboard.posts).to eq(visible_posts)
    end
  end
end
