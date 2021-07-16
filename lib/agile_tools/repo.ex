defmodule AgileTools.Repo do
  use Ecto.Repo,
    otp_app: :agile_tools,
    adapter: Ecto.Adapters.Postgres
end
