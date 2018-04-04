#!/usr/bin/env ruby

require './tokenizer'
require './parser'
require './generator'

tokens = Tokenizer.new(File.read('test.src')).tokenize
tree = Parser.new(tokens).parse
code = Generator.new.generate(tree)

RUNTIME = 'function add(x, y) { return x + y; }'
TEST = 'console.log(f(1, 2));'
puts [RUNTIME, code, TEST].join("\n")
