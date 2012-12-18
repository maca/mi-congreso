require "open-uri"

module Scraper
  class Districts

    BASE_URL = "http://sitl.diputados.gob.mx/LXII_leg/listado_diputados_gpnp.php?tipot=TOTAL"

    def document
      @document ||= Nokogiri.parse(open(BASE_URL))
    end

    def members_nodes
      nodes = document.css("table tr:nth-child(4) table tr")
      nodes = nodes.map {|n| n if n.css("td[class=textoNegro]").size > 0 }.compact
    end

    def members
      members_nodes.map do |node|
        internal_nodes = node.css("td[class=textoNegro]")
        name = internal_nodes[0].text
        state_name = internal_nodes[1].text
        district_or_region = internal_nodes[2].text

        MemberDistrict.new(name, state_name, district_or_region)
      end
    end
  end

  class MemberDistrict

    attr_reader :name, :state_name, :district_or_region

    def initialize(name, state_name, district_or_region)
      @name = name.gsub(/^\d+\s/, "")
      @state_name = state_name
      @district_or_region = district_or_region
    end

    def district_number
      if district_or_region.match(/Dtto/)
        district_or_region.match(/\d+/).to_s
      end
    end

    def region_number
      if district_or_region.match(/Circ/)
        district_or_region.match(/\d+/).to_s
      end
    end
  end
end