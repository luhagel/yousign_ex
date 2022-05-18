defmodule Yousign do
  @moduledoc """
  Documentation for `Yousign`.
  """

  def child_spec(opts) do
    children = [
      Yousign.API.child_spec()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Yousign.Supervisor] ++ opts
    Supervisor.start_link(children, opts)
  end
end
