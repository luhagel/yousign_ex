defmodule Yousign.API.SignatureRequests do
  import Yousign.Request

  alias Yousign.SignatureRequest
  alias Yousign.SignatureRequestInput

  def list, do: make_request(:get, "signature_requests")

  def get(id), do: make_request(:get, "signature_requests/#{id}")

  @doc """
  Activates the given signature request
  See: https://developers.yousign.com/reference/post-signature_requests-signaturerequestid-signatures
  """
  def activate(id), do: make_request(:post, "signature_requests/#{id}/activate", 201)

  @doc """
  Cancels the given signature request
  """
  def cancel(id), do: make_request(:post, "signature_requests/#{id}/cancel", 201)

  @doc """
  Creates a new signature request
  """
  @spec create(%SignatureRequestInput{}) :: {:error, any()} | {:ok, %SignatureRequest{}}
  def create(body) do
    make_request_with_body(:post, "signature_requests", body, 201)
  end
end
