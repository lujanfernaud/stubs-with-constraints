# Upcase: Test Doubles

## Stubs with Constraints

Implementing a stub with constraints for the [Test Doubles](https://thoughtbot.com/upcase/test-doubles) course.

### Before

```ruby
# dashboard_spec.rb

describe "#posts" do
  it "returns posts visible to the current user" do
    user = create(:user)
    other_user = create(:user)
    create :post, user: other_user, published: true, title: "published_one"
    create :post, user: other_user, published: true, title: "published_two"
    create :post, user: other_user, published: false, title: "unpublished"
    create :post, user: user, published: false, title: "visible_one"
    create :post, user: user, published: false, title: "visible_two"
    dashboard = Dashboard.new(posts: Post.all, user: user)

    result = dashboard.posts

    expect(result.map(&:title)).to match_array(%w(
      published_one
      published_two
      visible_one
      visible_two
    ))
  end
end
```

### After

```ruby
# dashboard_spec.rb

describe "#posts" do
  it "returns posts visible to the current user" do
    user       = create(:user)
    user_posts = double("user_posts")
    dashboard  = Dashboard.new(posts: Post.all, user: user)

    allow(Post).to receive(:visible_to).with(user).and_return(user_posts)

    expect(dashboard.posts).to eq(user_posts)
  end
end
```
