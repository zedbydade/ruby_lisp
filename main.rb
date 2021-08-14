require_relative "env"
require_relative "eval"
require_relative "reader"

def repl
  _eval = Eval.new
  prompt = ">>> "
  second_prompt = "> "

  while true
    print prompt
    code = gets.chomp
    until code.count("(") == code.count(")")
      print second_prompt
      code += gets.chomp
    end
    reader = code.empty? ? nil : Reader.new(code)
    if reader
      p _eval.run(reader.parse, $global_env)
    end
  end
end

_eval = Eval.new
if ARGV.length == 0
  repl()
else
  File.open(ARGV[0], "r") do |f|
    f.read().each_line do |line|
      reader = Reader.new(line)
      _eval.run(reader.parse, $global_env)
    end
  end
end
