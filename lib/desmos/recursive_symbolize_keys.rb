class Hash

  def recursive_symbolize_keys
    hash = {}
    each_pair do |k,v|
      if v.is_a?(Hash)
        hash.store(k.to_sym,v.recursive_symbolize_keys)
      else
        hash.store(k.to_sym,v)
      end
    end
    hash
  end
  
  def recursive_symbolize_keys!
    self.replace(recursive_symbolize_keys)
  end

end