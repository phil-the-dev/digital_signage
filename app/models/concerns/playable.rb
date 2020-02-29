module Playable 
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def resolve
      raise "this should be over written in subclasses"
     end
    
     def playable_id
      "#{self.class.name}:#{self.id}"
     end
  end

  module ClassMethods
  end

  def self.parse playable_string
    playable_class, id = playable_string.split(":")

    playable_class.classify.constantize.find(id.to_i)
  end
 
end