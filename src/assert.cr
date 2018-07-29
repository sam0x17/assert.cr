macro assert!(expr)
  {% if expr.is_a? StringLiteral %}
    (raise "assertion {{expr.id}} failed" unless Assert.to_b({{expr}})) || true
  {% else %}
    (raise "assertion {{expr}} failed" unless Assert.to_b({{expr}})) || true
  {% end %}
end

module Assert
  def self.to_b(expr)
    if expr.is_a? Bool
      return expr
    elsif expr.nil?
      return false
    elsif expr.is_a? Int
      return expr > 0
    elsif expr.is_a? Float
      return expr > 0.0
    elsif expr.is_a? String
      return false if expr == ""
      return Assert.to_b(expr.to_i) if expr.to_i.to_s == expr
      return true if expr.downcase == "true"
      return false if expr.downcase == "false"
      true
    end
    false
  end
end
