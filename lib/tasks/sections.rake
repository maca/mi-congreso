# encoding: utf-8

namespace :sections do

  desc "Import regions"
  task :import_regions => :environment do
    regions_json = JSON.parse(File.read(Rails.root.to_s + "/db/seeds/regions.json"))
    regions_json.each do |region_hash|
      Region.create(region_hash)
    end
  end

  desc "Import state region_ids"
  task :import_region_ids => :environment do
    states_json = JSON.parse(File.read(Rails.root.to_s + "/db/seeds/states.json"))
    states_json.each do |state_hash|
      state = State.find_by_name(state_hash["name"])

      if state
        state.region_id = state_hash["region_id"]
        state.save
      else
        puts "The state #{state_hash["name"]} was not found"
      end
    end
  end

  desc "Import districts"
  task :import_districts => :environment do
    states_json = JSON.parse(File.read(Rails.root.to_s + "/db/seeds/states.json"))
    districts_json = JSON.parse(File.read(Rails.root.to_s + "/db/seeds/districts.json"))
    districts_json.each do |district_hash|
      state_id = district_hash.delete("state_id")
      district = District.new(district_hash)
      state_hash = states_json.find {|h| h["id"] == state_id}
      state = State.find_by_name(state_hash["name"])
      district.state_id = state.id
      district.save
    end
  end

  desc "Import sections"
  task :import_sections => :environment do
    sections_json = JSON.parse(File.read(Rails.root.to_s + "/db/seeds/sections.json"))
    sections_json.each do |section_hash|
      Section.create(section_hash)
    end
  end
end