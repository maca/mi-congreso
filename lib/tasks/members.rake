require 'csv'
require 'open-uri'

namespace :members do
  desc "Import members from CSV file"
  task :import => :environment do
    CSV.foreach("#{Rails.root.to_s}/db/seeds/members.csv", headers: true) do |row|
      party = Party.find_or_create_by_name(name: row["partido"])
      state = State.find_or_create_by_name(name: row["estado"])

      election_type = ""
      election_type = "relativa" if row["eleccion"].to_s.match(/relativa/)
      election_type = "proporcional" if row["eleccion"].to_s.match(/proporcional/)

      begin
        photo = open(row["url_foto"])
      rescue
        photo = nil
      end

      Member.create(name: row["nombre"],
                    party_id: party.id,
                    state_id: state.id,
                    district: row["distrito"],
                    substitute: row["suplente"],
                    election_type: election_type,
                    email: row["email"],
                    photo: photo)
    end
  end

  desc "Add photo to members"
  task :add_photo => :environment do
    CSV.foreach("#{Rails.root.to_s}/db/seeds/members.csv", headers: true) do |row|
      photo = open(row["url_foto"]) rescue nil
      member = Member.find_by_email(row["email"])

      if member && photo
        member.photo = photo
        member.save
      end
    end
  end
end