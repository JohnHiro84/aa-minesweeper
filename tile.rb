class Tile

  attr_accessor :hidden_value, :revealed, :flag

  def initialize
    @hidden_value = "^"
    @revealed = false
    @flag = false
  end
  # def hidden_value
  #   @hidden_value
  # end
  #
  # def hidden_value=(new_value)
  #   @hidden_value = new_value
  # end

end

#
# tike = Tile.new
# print tike.hidden_value
# tike.hidden_value = "mop"
# print tike.hidden_value
