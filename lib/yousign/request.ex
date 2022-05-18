defmodule Yousign.Request do
  @moduledoc """
  A module for handling the internal requests to the Yousign API
  """

  alias Yousign.Config

  def make_request(method \\ :get, endpoint \\ "", args \\ []) do
    url = "#{base_url()}/#{endpoint}"

    {:ok, res} =
      method
      |> Finch.build(url, [{"Authorization", "Bearer #{Config.resolve(:api_key)}"}])
      |> Finch.request(Yousign.API)

    Jason.decode!(Map.get(res, :body))
  end

  def base_url() do
    if(Config.resolve(:use_sandbox, false)) do
      "https://staging-api.yousign.com"
    else
      "https://api.yousign.com"
    end
  end
end