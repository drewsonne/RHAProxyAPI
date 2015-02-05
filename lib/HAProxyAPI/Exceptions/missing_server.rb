class MissingServer < ArgumentError

  def initialize(backend_name)
    super("Server does not exist: '#{backend_name}'")
  end

end