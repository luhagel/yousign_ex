defmodule Yousign.API do
  @moduledoc """
  Yousign API Module
  """

  alias Yousign.Config
  alias Yousign.Request

  alias Finch.Response

  def child_spec do
    {Finch,
     name: __MODULE__,
     pools: %{
       Request.base_url() => [size: pool_size()]
     }}
  end

  defp pool_size, do: 25
end
