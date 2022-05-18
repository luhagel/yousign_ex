defmodule Yousign.API.Members do
  import Yousign.Request

  def list, do: make_request(:get, "members")
end
