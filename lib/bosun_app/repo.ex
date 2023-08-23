defmodule BosunApp.Repo do
  use Ecto.Repo,
    otp_app: :bosun_app,
    adapter: Ecto.Adapters.Postgres
end
