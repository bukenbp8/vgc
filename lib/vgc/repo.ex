defmodule Vgc.Repo do
  use Ecto.Repo,
    otp_app: :vgc,
    adapter: Ecto.Adapters.Postgres
end
