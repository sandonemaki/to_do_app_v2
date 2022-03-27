class PresenterEdit
  attr_reader :id, :content, :errors

  def initialize(id:, content:, errors: {})
    @id = id #Integer
    @content = content #String
    @errors = errors #Hash
  end
end
