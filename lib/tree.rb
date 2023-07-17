# frozen_string_literal: true

# Class to build balance binary search tree
class Tree
  attr_accessor :root

  def initialize(root = nil)
    @root = Node.new(root)
  end

  # Build a balance binary search tree
  def build_tree(arr, start_idx = 0, end_idx = arr.size)
    arr.sort!.uniq! # Sort and remove duplicates
    return if start_idx > end_idx

    mid_idx = (start_idx + end_idx) / 2
    root = Node.new(arr[mid_idx])
    root.left = build_tree(arr, start_idx, mid_idx - 1)
    root.right = build_tree(arr, mid_idx + 1, end_idx)
    @root = root
  end

  # Print binary search tree
  # Method from https://www.theodinproject.com/lessons/ruby-binary-search-trees
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.root}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
