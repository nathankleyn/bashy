class Hash
  
  def deep_merge(hash)
    target = self.dup
    hash.keys.each do |key|
      if hash[key].is_a?(Hash) && self[key].is_a?(Hash)
        target[key] = target[key].deep_merge(hash[key])
        next
      end
      target[key] = hash[key]
    end
    target
  end
  
  def deep_merge!(hash)
    self.replace(self.deep_merge(hash))
  end
  
end
