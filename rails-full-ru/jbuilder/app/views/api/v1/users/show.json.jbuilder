json.extract! @user, :id, :email, :address
json.set! :full_name, "#{@user.first_name} #{@user.last_name}"

json.posts @posts do |post|
  json.partial! 'api/v1/users/post', post: post
end


