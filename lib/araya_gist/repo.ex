defmodule ArayaGist.Repo do
  use Ecto.Repo,
    otp_app: :araya_gist,
    adapter: Ecto.Adapters.Postgres
end
