require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts visible to the current user" do
      user       = create(:user)
      user_posts = double("user_posts")
      dashboard  = Dashboard.new(posts: Post.all, user: user)

      allow(Post).to receive(:visible_to).with(user).and_return(user_posts)

      expect(dashboard.posts).to eq(user_posts)
    end
  end
end
