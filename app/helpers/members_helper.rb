module MembersHelper

  def link_to_twitter_username(username)
    link_to "@#{username}", "http://www.twitter.com/#{username}", target: "blank"
  end
end
