class VoteValue

  FOR     = "for"
  AGAINST = "against"
  NEUTRAL = "neutral"

  def self.to_i(string)
    if string.to_s.to_i > 0
      value = new(string.to_i)
    else
      value = case string.to_s
              when FOR     then new(1)
              when AGAINST then new(2)
              when NEUTRAL then new(3)
              when
                new(0)
              end
    end
    value.to_i
  end

  def initialize(number)
    @number = number
  end

  def to_s
    case @number
    when 1 then FOR
    when 2 then AGAINST
    when 3 then NEUTRAL
    else
      ""
    end
  end

  def to_sym
    self.to_s.to_sym
  end

  def to_i
    @number
  end
end