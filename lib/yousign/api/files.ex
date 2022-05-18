defmodule Yousign.API.Files do
  import Yousign.Request

  def list, do: make_request(:get, "files")
end
