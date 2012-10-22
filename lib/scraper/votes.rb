require 'open-uri'

module Scraper
  class Votes

    attr_reader :base_url, :vote_type, :document

    # The format of the URL is as follows: http://gaceta.diputados.gob.mx/voto62/ordi11/lanordi11.php3?evento=3&lola[11]=1
    # In order to get the different types of votes we need to change the number in the square bracket next to lola.
    # The meaning of those numbers are:
    #   1. lola[11] are the votes For
    #   2. lola[12] are the votes Against
    #   3. lola[13] are the Neutral votes
    #   4. lola[14] are the Quorum votes
    #   5. lola[15] are the members that were absent in the session
    #
    def initialize(base_url, vote_type)
      @base_url = base_url
      @vote_type = case vote_type.to_sym
                   when :for then 11
                   when :against then 12
                   when :neutral then 13
                   when :quorum then 14
                   when :absent then 15
                   end
    end

    def document
      @document ||= Nokogiri.parse(open("#{base_url}&lola[#{vote_type}]=1"))
    end

    # Returns a array of Nokogiri objects representing the tables with the votes for each party
    # The order of the tables is as follows:
    #
    #   1. Partido Revolucionario Institucional
    #   2. Partido Acción Nacional
    #   3. Partido de la Revolución Democrática
    #   4. Partido Verde Ecologista de México
    #   5. Partido del Trabajo
    #   6. Partido Nueva Alianza
    #   7. Movimiento Ciudadano
    #   8. Sin partido
    #
    def party_nodes
      @party_nodes ||= document.css("td[width='86%'] table")
    end

    def member_nodes
      nodes = []
      party_nodes.each do |node|
        node.css("td").each do |sub_node|
          nodes += sub_node.children.to_a
        end
      end
      nodes = nodes.delete_if {|n| n.text.blank? }
    end

    def member_names
      nodes = member_nodes.map(&:text)
      nodes = nodes.map {|n| n.gsub(/\d{1,4}:/, "") }
    end
  end
end