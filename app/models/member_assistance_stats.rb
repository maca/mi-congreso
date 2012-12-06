class MemberAssistanceStats

  attr_reader :member

  def initialize(member)
    @member = member
  end

  def assistances
    @assistances ||= member.assistances
  end

  def assisted_count
    @assisted_count ||= begin
      assistances.find_all {|a| a.value == 1}.size
    end
  end

  def total_count
    @total_count ||= assistances.size
  end

  def assisted_percentage
    @assisted_percentage ||= (assisted_count.to_f / total_count.to_f)
  end
end