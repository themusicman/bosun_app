defimpl Bosun.Policy, for: Any do
  alias Bosun.Context

  def resource_id(resource, _, _, _, _) do
    resource.id
  end

  def subject_id(_resource, _action, subject, _context, _options) do
    subject.id
  end

  def permitted?(_resource, _action, _subject, context, _options) do
    Context.deny(context, "Impermissible")
  end
end
