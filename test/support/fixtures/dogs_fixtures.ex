defmodule BosunApp.DogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BosunApp.Dogs` context.
  """

  @doc """
  Generate a dog.
  """
  def dog_fixture(attrs \\ %{}) do
    {:ok, dog} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> BosunApp.Dogs.create_dog()

    dog
  end
end
