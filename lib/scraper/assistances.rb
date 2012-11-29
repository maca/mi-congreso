require "open-uri"

module Scraper
  class Assistances

    BASE_URL = "http://sitl.diputados.gob.mx/LXII_leg/listados_asistenciasnplxii.php"

    attr_reader :session_id, :party_id

    # The session_id is a autoincremented number assigned to each session in the congress
    # Tha party_id is a number assigned to each party, currently the party ID's are: 1,2,3,4,5,6 and 12
    #
    def initialize(session_id, party_id)
      @session_id = session_id
      @party_id = party_id
    end

    def document
      @document ||= Nokogiri.parse(open("#{BASE_URL}?partidot=#{party_id}&sesiont=#{session_id}"))
    end

    # The page with the assistances is unsuprisingly built with nested tables.
    #
    def member_nodes
      nodes = document.css("table tr:nth-child(4) table tr")
      nodes = nodes[4..-1]
    end

    def members
      member_nodes.map do |node|
        name = node.css("td:nth-child(2)").text
        value = node.css("td:nth-child(3)").text
        MemberAssistance.new(name, value)
      end
    end
  end

  class MemberAssistance

    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value.strip.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    end
  end
end