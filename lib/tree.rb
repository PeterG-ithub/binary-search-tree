# frozen_string_literal: true

# Class to build balance binary search tree
class Tree
  attr_accessor :root

  def initialize(root = nil)
    @root = Node.new(root)
  end

  # Build a balance binary search tree
  def build_tree(arr, start_idx = 0, end_idx = arr.uniq.size)
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
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # function to insert a value to the tree
  def insert(value, node = @root)
    # Base case
    if node.data.nil?
      node.data = value
      return
    end
    return if value == node.data # Return if value already exist

    # Loop
    node = if value > node.data
             node.right
           else
             node.left
           end
    insert(value, node)
  end

  # function to delete a value from the tree
  def delete(value, node = @root)
    # Base case
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # one or zero child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # two children
      temp = node.right
      until temp.left.nil?
        temp = temp.left
        temp
      end
      node.data = temp.data
      node.right = delete(temp.data, node.right)
    end
    node
  end

  # function to find a value
  def find(value, node = @root)
    return node if node.data == value

    node = if value > node.data
             node.right
           else
             node.left
           end
    find(value, node)
  end

  # function to output an array in level order
  def level_order(node = @root)
    queue = []
    data = []
    queue.push(node)
    until queue.empty?
      current = queue[0]
      yield current.data if block_given?
      data << current.data
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
      queue.shift
    end
    data unless block_given?
  end
end
