require 'csv'

namespace :members do
  desc "Import members from CSV file"
  task :import => :environment do
    CSV.foreach("#{Rails.root.to_s}/db/seeds/members.csv", headers: true) do |row|
      party = Party.find_or_create_by(name: row["partido"])
      state = State.find_or_create_by(name: row["estado"])

      Member.create(name: row["nombre"], party: party, state: state, district: row["distrito"])
    end
  end
end
