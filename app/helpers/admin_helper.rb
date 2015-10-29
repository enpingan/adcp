module AdminHelper

  def get_processor(db_val)
    ret = db_val.split(' ').first
    val = 100 / 16 * ret.to_i
    return val
  end

  def get_ram(db_val)
    ret = db_val.split(' ').first
    val = 100 * ret.to_i / 64
    return val
  end
  
end
