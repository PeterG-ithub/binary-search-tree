# frozen_string_literal: true

# Node class for BST
class Node
  attr_accessor :root, :left, :right

  def initialize(root, left = nil, right = nil)
    @root = root
    @left = left
    @right = right
  end
end
