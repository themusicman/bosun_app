defmodule BosunAppWeb.DogLive.FormComponent do
  use BosunAppWeb, :live_component

  alias BosunApp.Dogs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage dog records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="dog-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Dog</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{dog: dog} = assigns, socket) do
    changeset = Dogs.change_dog(dog)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"dog" => dog_params}, socket) do
    changeset =
      socket.assigns.dog
      |> Dogs.change_dog(dog_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"dog" => dog_params}, socket) do
    save_dog(socket, socket.assigns.action, dog_params)
  end

  defp save_dog(socket, :edit, dog_params) do
    case Dogs.update_dog(socket.assigns.dog, dog_params) do
      {:ok, dog} ->
        notify_parent({:saved, dog})

        {:noreply,
         socket
         |> put_flash(:info, "Dog updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_dog(socket, :new, dog_params) do
    case Dogs.create_dog(dog_params) do
      {:ok, dog} ->
        notify_parent({:saved, dog})

        {:noreply,
         socket
         |> put_flash(:info, "Dog created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
