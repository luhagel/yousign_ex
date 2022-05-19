defmodule Yousign.API.Files do
  import Yousign.Request

  def list, do: make_request(:get, "files")

  def create(args) do
    :post
    |> make_request("files", args)
  end
end
