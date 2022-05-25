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

  def get_api_url, do: Request.base_url()
  def get_web_url, do: Request.web_url()

  defp pool_size, do: 25
end
