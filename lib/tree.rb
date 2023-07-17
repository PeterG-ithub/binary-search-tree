class Tree
  attr_accessor :root

  def initialize(root = nil)
    @root = Node.new(root)
  end
end