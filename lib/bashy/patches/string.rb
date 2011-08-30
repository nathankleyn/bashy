class String

  def match_any(patterns)
    matches = nil
    patterns.detect { |p| matches = self.match(Regexp.new(p)) }
    matches
  end
  
  def underscore
    self.downcase.gsub(" ", "_")
  end
  
  def underscore!
    self.replace(self.underscore)
  end
  
end # class
