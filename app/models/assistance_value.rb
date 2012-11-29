class AssistanceValue

  ASSISTANCE    = "asistencia"
  ABSENCE       = "inasistencia"
  ALLOWED       = "permiso mesa directiva"
  JUSTIFIED     = "justificada"
  IN_COMISSON   = "oficial comision"
  DOCUMENT      = "cedula"

  def self.to_i(string)
    if string.to_s.to_i > 0
      value = new(string.to_i)
    else
      value = case string.to_s
              when ASSISTANCE   then new(1)
              when ABSENCE      then new(2)
              when ALLOWED      then new(3)
              when JUSTIFIED    then new(4)
              when IN_COMISSON  then new(5)
              when DOCUMENT     then new(6)
              else
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
    when 1 then ASSISTANCE
    when 2 then ABSENCE
    when 3 then ALLOWED
    when 4 then JUSTIFIED
    when 5 then IN_COMISSON
    when 6 then DOCUMENT
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