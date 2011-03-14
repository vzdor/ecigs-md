Factory.define :user, :class => User do |u|
  u.sequence(:email) { |n| "user#{n}@host.com" }
  u.password "qwe123"
  u.password_confirmation "qwe123"
end

Factory.define :admin, :class => User do |u|
  u.email "vzdor@ecigs.md"
  u.is_admin true
  u.password "qwe123"
  u.password_confirmation "qwe123"
end
