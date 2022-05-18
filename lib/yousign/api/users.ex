defmodule Yousign.API.Users do
  import Yousign.Request

  def list, do: make_request(:get, "users")
end
