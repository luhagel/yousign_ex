defmodule Yousign.API.Files do
  import Yousign.Request

  @doc """
  Lists all files
  """
  def list, do: make_request(:get, "files")

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

  @doc """
  Get the content of the requested file as base64.

  Accepts either `:base64` or `:binary` as an optional format parameter.
  Default is `:base64`
  """
  @spec get_file_content(binary(), atom()) :: {:ok, binary()}
  def get_file_content(id, format \\ :base64)

  def get_file_content(id, :base64) do
    :get
    |> make_raw_request("#{id}/download")
  end

  def get_file_content(id, :binary) do
    :get
    |> make_raw_request("#{id}/download?alt=media")
  end
end
