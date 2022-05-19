defmodule Yousign.API.Procedures do
  import Yousign.Request

  def list, do: make_request(:get, "procedures")

  def create(args) do
    :post
    |> make_request("procedures", args)
  end
end
