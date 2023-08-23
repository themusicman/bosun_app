defmodule BosunApp.Dogs.Dog do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name]}

  schema "dogs" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(dog, attrs) do
    dog
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
