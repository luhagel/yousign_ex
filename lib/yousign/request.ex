defmodule Yousign.Request do
  @moduledoc """
  A module for handling the internal requests to the Yousign API
  """

  alias Yousign.Config

  @doc """
  Makes a request to the Yousign API

  ## Examples

      iex> Yousign.Request.make_request(:get, "signature_requests")
      {:ok, %{"data" => [], "meta" => %{"pagination" => %{"total" => 0}}}}

      iex> Yousign.Request.make_request(:get, "signature_requests/123")
      {:ok, %{"data" => %{"id" => "123", "name" => "test"}}}

      iex> Yousign.Request.make_request(:get, "signature_requests/invalid")
      {:error, 404}
  """
  @spec make_request(atom(), String.t(), non_neg_integer()) :: {:error, any()} | {:ok, any()}
  def make_request(method, endpoint, success_status_code \\ 200)
      when is_integer(success_status_code) do
    url = "#{base_url()}/#{endpoint}"

    {:ok, res} =
      method
      |> Finch.build(url, [{"Authorization", "Bearer #{Config.resolve(:api_key)}"}])
      |> Finch.request(Yousign.API)

    case res do
      %{status: ^success_status_code} -> {:ok, Jason.decode!(Map.get(res, :body), keys: :atoms)}
      _ -> {:error, {res.status, Jason.decode!(Map.get(res, :body), keys: :atoms)}}
    end
  end

  def make_request_with_body(method, endpoint, body, success_status_code \\ 200) do
    url = "#{base_url()}/#{endpoint}"

    {:ok, res} =
      method
      |> Finch.build(
        url,
        [
          {"Authorization", "Bearer #{Config.resolve(:api_key)}"},
          {"Content-Type", "application/json"}
        ],
        Jason.encode!(body)
      )
      |> Finch.request(Yousign.API)

    case res do
      %{status: ^success_status_code} -> {:ok, Jason.decode!(Map.get(res, :body), keys: :atoms)}
      _ -> {:error, {res.status, Jason.decode!(Map.get(res, :body), keys: :atoms)}}
    end
  end

  def make_multipart_request(:post, endpoint, body, success_status_code \\ 200) do
    url = "#{base_url()}/#{endpoint}"

    body_stream = Multipart.body_stream(body)
    content_length = Multipart.content_length(body)
    content_type = Multipart.content_type(body, "multipart/form-data")

    headers = [
      {"Content-Type", content_type},
      {"Content-Length", to_string(content_length)},
      {"Authorization", "Bearer #{Config.resolve(:api_key)}"}
    ]

    {:ok, res} =
      :post
      |> Finch.build(
        url,
        headers,
        {:stream, body_stream}
      )
      |> Finch.request(Yousign.API)

    case res do
      %{status: ^success_status_code} -> {:ok, Jason.decode!(Map.get(res, :body), keys: :atoms)}
      _ -> {:error, {res.status, Jason.decode!(Map.get(res, :body), keys: :atoms)}}
    end
  end

  @doc """
  Returns the base URL for the Yousign API based on the current envorinment
  """
  def base_url(sandbox \\ Config.resolve(:use_sandbox, false))
  def base_url(true), do: "https://api-sandbox.yousign.app/v3"
  def base_url(false), do: "https://api.yousign.app/v3"

  @doc """
  Returns the base URL for the Yousign webapp based on the current envorinment
  """
  def web_url(sandbox \\ Config.resolve(:use_sandbox, false))
  def web_url(true), do: "https://staging-webapp.yousign.com"
  def web_url(false), do: "https://webapp.yousign.com"
end
