defmodule Theclap.Repo do
  use Ecto.Repo,
    otp_app: :theclap,
    adapter: Ecto.Adapters.Postgres
end
