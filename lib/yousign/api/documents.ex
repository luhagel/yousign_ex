defmodule Yousign.API.Documents do
  import Yousign.Request

  alias Yousign.Document
  alias Multipart.Part
  alias Yousign.DocumentInput

  @doc """
    Gets a single document by its id

    ## Examples

        iex> Yousign.API.Documents.get("123")
        {:ok, %{"data" => %{"id" => "123", "name" => "test"}}}

        iex> Yousign.API.Documents.get("invalid")
        {:error, 404}
  """
  @spec get(String.t(), String.t()) :: {:error, any()} | {:ok, any()}
  def get(signature_request_id, id) do
    make_request(:get, "signature_requests/#{signature_request_id}/documents/#{id}")
  end

  @doc """
  List all documents in a signature request

  ## Examples

      iex> Yousign.API.Documents.list("123")
      {:ok, %{"data" => [], "meta" => %{"pagination" => %{"total" => 0}}}}

      iex> Yousign.API.Documents.list("123")
      {:ok, %{"data" => [%{"id" => "123", "name" => "test"}], "meta" => %{"pagination" => %{"total" => 1}}}}
  """
  @spec list(String.t()) :: {:error, any()} | {:ok, any()}
  def list(signature_request_id) do
    make_request(:get, "signature_requests/#{signature_request_id}/documents")
  end

  @doc """
  Creates a new document
  """
  @spec create(%DocumentInput{}, String.t() | boolean()) :: {:error, any()} | {:ok, %Document{}}
  def create(body, filename \\ true) do
    {:ok, path} = base64_to_file(body.file)

    body =
      Multipart.new()
      |> Multipart.add_part(Part.text_field(Atom.to_string(Map.get(body, :nature, nil)), :nature))
      |> Multipart.add_part(
        Part.text_field(to_string(Map.get(body, :parse_anchors, false)), :parse_anchors)
      )
      |> Multipart.add_part(Part.file_field(path, :file, filename: filename))

    case make_multipart_request(:post, "documents", body, 201) do
      {:ok, data} ->
        File.rm!(path)
        {:ok, data}

      {:error, error} ->
        File.rm!(path)
        {:error, error}
    end
  end

  @doc """
  Creates a new document and adds it to the given signature request
  """
  @spec add_to_signature_request(String.t(), %DocumentInput{}, String.t() | boolean()) ::
          {:error, any()} | {:ok, %Document{}}
  def add_to_signature_request(signature_request_id, body, filename \\ true) do
    {:ok, path} = base64_to_file(body.file)

    body =
      Multipart.new()
      |> Multipart.add_part(Part.text_field(Atom.to_string(Map.get(body, :nature, nil)), :nature))
      |> Multipart.add_part(
        Part.text_field(to_string(Map.get(body, :parse_anchors, false)), :parse_anchors)
      )
      |> Multipart.add_part(Part.file_field(path, :file, filename: filename))

    case make_multipart_request(
           :post,
           "signature_requests/#{signature_request_id}/documents",
           body,
           201
         ) do
      {:ok, data} ->
        File.rm!(path)
        {:ok, data}

      {:error, error} ->
        File.rm!(path)
        {:error, error}
    end
  end

  @doc """
  Downloads all the documents attached to a signature request

  Version Options:
    - :completed: downloads the completed version of the documents
    - :current: downloads the current version of the documents

  Defaults to :current
  """
  @spec download(String.t(), atom()) :: {:error, any()} | {:ok, any()}
  def download(signature_request_id, version \\ :current)

  def download(signature_request_id, :completed) do
    make_request(
      :get,
      "signature_requests/#{signature_request_id}/documents/download?version=completed"
    )
  end

  def download(signature_request_id, :current) do
    make_request(
      :get,
      "signature_requests/#{signature_request_id}/documents/download?version=current"
    )
  end

  @spec base64_to_file(String.t()) :: {:error, any()} | {:ok, String.t()}
  defp base64_to_file(encoded_string) do
    with {:ok, data} <- Base.decode64(encoded_string),
         {:ok, path} <-
           Temp.path(prefix: "yousign_ex_temp", suffix: ".pdf"),
         {:ok, file} <- File.open(path, [:write, :binary]),
         :ok <- IO.binwrite(file, data),
         :ok <- File.close(file) do
      {:ok, path}
    end
  end
end
