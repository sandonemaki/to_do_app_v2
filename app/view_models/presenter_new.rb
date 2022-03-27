class PrsenterNew
  attr_reader :content, :errors

  def initialize(content:, errors: {})
    @content = content #String or nil
    @errors = errorsi #Hash
end

