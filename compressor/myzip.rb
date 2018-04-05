#!/usr/bin/env ruby

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
  nodes
end

Node = Struct.new(:left, :right, :count)
Leaf = Struct.new(:byte, :count)

p build_tree('abbcccc')
