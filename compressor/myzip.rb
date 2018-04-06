#!/usr/bin/env ruby

def compress(original)
  tree = build_tree(original)
  table = build_table(tree)

  original.bytes.each do |byte|
    bits = look_up_byte(table, byte)
  end
end

def look_up_byte(table, byte)
  table.each do |row|
    if row.byte == byte
      return row.bits
    end
  end
end

def build_tree(original)
  bytes = original.bytes
  unique_bytes = bytes.uniq

  nodes = unique_bytes.map do |byte|
    Leaf.new(byte, bytes.count(byte))
  end
  until nodes.length == 1
    node1 = nodes.delete(nodes.min_by(&:count))
    node2 = nodes.delete(nodes.min_by(&:count))
    nodes << Node.new(node1, node2, node1.count + node2.count)
  end
  nodes.fetch(0)
end

def build_table(node, path = [])
  if node.is_a? Node
    build_table(node.left, path + [0]) + build_table(node.right, path + [1])
  else
    [TableRow.new(node.byte, path)]
  end
end

Node = Struct.new(:left, :right, :count)
Leaf = Struct.new(:byte, :count)
TableRow = Struct.new(:byte, :bits)

p compress('abbcccc')
