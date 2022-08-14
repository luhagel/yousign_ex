defmodule Yousign.API.Files do
  import Yousign.Request

  @doc """
  Lists all files
  """
  def list, do: make_request(:get, "files")

  @doc """
  Get a single file
  """
  def get(id) when is_binary(id) do
    :get
    |> make_request("/files/#{id}")
  end

  @doc """
  Creates a new file, accepts a payload built with build_file/2 or a custom one
  """
  def create(file) do
    :post
    |> make_request("files", file)
  end

  @doc """
  Build a new File API Payload
  """
  def build_file(name, content) do
    %{
      name: name,
      content: content
    }
  end
end
