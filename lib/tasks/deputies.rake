require 'csv'
require 'open-uri'

namespace :deputies do
  desc "Import deputies from CSV file"
  task :import => :environment do
    CSV.foreach("#{Rails.root.to_s}/db/seeds/deputies.csv", headers: true) do |row|
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

      Deputy.create(name: row["nombre"],
                    party_id: party.id,
                    state_id: state.id,
                    district: row["distrito"],
                    substitute: row["suplente"],
                    election_type: election_type,
                    email: row["email"],
                    photo: photo)
    end
  end

  desc "Add photo to deputies"
  task :add_photo => :environment do
    CSV.foreach("#{Rails.root.to_s}/db/seeds/deputies.csv", headers: true) do |row|
      photo = open(row["url_foto"]) rescue nil
      deputy = Deputy.find_by_email(row["email"])

      if deputy && photo
        deputy.photo = photo
        deputy.save
      end
    end
  end
end