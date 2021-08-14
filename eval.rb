class Eval
  def run(code, env)
    case code.class.to_s
    when "Array"
      if code.empty?
        return []
      end
      case code.first
      when :quote
        _,exp = code
        exp
      when :def
        _,var,exp = code
        env[var] = run(exp,env)
        nil
      when :if
        _, test, true_exp, false_exp = code
        run(run(test, env) ? true_exp : false_exp, env)
      when :lambda
        _,vars,exp = code
        lambda{|*args|run(exp,Env.new(vars,args,env))}
      else
        func, *args = code.inject([]) { |acc, exp| acc << run(exp, env) }
        func[*args]
      end
    when "Symbol"
      env.get(code)
    else
        code
    end
  end
end
