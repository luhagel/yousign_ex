defmodule Yousign.API.Procedures do
  import Yousign.Request

  def list, do: make_request(:get, "procedures")
end
