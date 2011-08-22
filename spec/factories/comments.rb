Factory.define :comment, :class => Comment do |comment|
  comment.score 4
  comment.content "test test"
  comment.association :user
  comment.association :commentable, :factory => :product
  comment.fullname "bob"
end
