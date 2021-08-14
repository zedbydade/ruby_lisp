class Env < Hash
  def initialize(params=[],args=[],outer={})
    h = Hash[params.zip(args)]
    @outer = outer
    self.merge!(h)
    self.merge!(yield) if block_given?
  end

  def get(key)
    if self.has_key?(key)
      self[key]
    elsif @outer.has_key?(key)
      @outer[key]
    else
      raise RuntimeError, "#{key} is not declared"
    end
  end

  def []=(key, value)
    unless self.has_key?(key)
      self.merge!({ key => value })
    else
      raise RuntimeError, "#{key} has already been declared"
    end
  end
end

$global_env = Env.new do {
  :+ => ->(a, b) { a + b },
  :- => ->(a, b) { a - b },
  :* => ->(a, b) { a * b },
  :/ => ->(a, b) { a / b },
  :% => ->(a, b) { a % b },
  :> => ->(a, b) { a > b },
  :>= => ->(a, b) { a >= b },
  :< => ->(a, b) { a > b },
  :<= => ->(a, b) { a <= b },
  :'=' => ->(a, b) { a == b },
  :puts => ->(a) { puts a },
} end
