module Interface
  extend ActiveSupport::Concern
  
  def method(name)
    define_method(name) { |*args|
      raise "interface method #{name} not implemented"
    }
  end
end