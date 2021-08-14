class Reader
    attr_reader :tokens

    def initialize(code)
      @tokens = code.scan(/[()]|[A-Za-z0-9\._]+|'.*?'|".*?"|[+-]?[0-9]+\.?[0-9]?|[\!#\$%&*+,\-\.\/:;<=>\?@\[\]\^_`{\|}\~]/)
    end

    def read_char
      @tokens.first
    end

    def next_token
      @tokens.shift
    end

    def parse
      token = next_token()
      case token
      when "("
        read_list()
      when /['"].*/
        token[1..-2]
      when /[+-]?[0-9]+\.?[0-9]?/
        token.include?(".") ? token.to_f : token.to_i
      else
        token.to_sym
      end
    end

    def read_list
      lst = Array.new
      until read_char() == ")"
        lst << parse()
      end
      next_token()
      lst
    end
  end
