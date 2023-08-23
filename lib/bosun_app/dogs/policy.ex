defimpl Bosun.Policy, for: BosunApp.Dogs.Dog do
  alias Bosun.Context

  def resource_id(resource, _, _, _, _) do
    resource.id
  end

  def subject_id(_resource, _action, subject, _context, _options) do
    subject.id
  end

  def permitted?(_resource, _action, _user, context, _options) do
    Context.permit(context, "All users can view dogs")
  end
end
