module MembersHelper

  def link_to_twitter_username(username)
    link_to "@#{username}", "http://www.twitter.com/#{username}", target: "blank"
  end

  def party_abbr(member)
    member.party.try(:short_name).to_s.downcase
  end
end
