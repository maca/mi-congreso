class DeputyAssistanceStats

  attr_reader :deputy

  def initialize(deputy)
    @deputy = deputy
  end

  def assistances
    @assistances ||= deputy.assistances
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
    return 0 if total_count == 0
    @assisted_percentage ||= (assisted_count.to_f / total_count.to_f)
  end
end