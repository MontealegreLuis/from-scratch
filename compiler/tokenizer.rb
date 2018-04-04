class Tokenizer
  TOKEN_TYPES = [
      [:def, /\bdef\b/],
      [:end, /\bend\b/],
      [:identifier, /\b[a-zA-Z]+\b/],
      [:integers, /\b[0-9]+\b/],
      [:oparen, /\(/],
      [:cparen, /\)/],
      [:comma, /,/],
  ].freeze

  def initialize(code)
    @code = code
  end

  def tokenize
    tokens = []
    until @code.empty?
      tokens << tokenize_one_token
      @code = @code.strip
    end
    tokens
  end

  private

  def tokenize_one_token
    TOKEN_TYPES.each do |type, regexp|
      tokenType = /\A(#{regexp})/
      next unless @code =~ tokenType
      value = Regexp.last_match(1)
      @code = @code[value.length..-1]
      return Token.new(type, value)
    end
    raise "Couldn't match token on #{@code.inspect}"
  end
end

Token = Struct.new(:type, :value)
