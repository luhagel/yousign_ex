defmodule Yousign.API.Procedures do
  import Yousign.Request

  @doc """
  Lists all procedures
  """
  def list, do: make_request(:get, "procedures")

  @doc """
  Get a procedure
  """
  def get(id), do: make_request(:get, id)

  @doc """
  Lists all procedures by member email
  """
  def list_by_member_email(email), do: make_request(:get, "procedures?member.email=#{email}")

  @doc """
  Creates a new procedure, accepts a procedure built with build_procedure/3 or a freeform API Payload
  """
  def create(args) do
    :post
    |> make_request("procedures", args)
  end

  @doc """
  Builds a API Procedure payload with the provided info, sets a lot of defaults
  """
  def build_procedure(info, members, config \\ %{}) do
    %{
      name: Map.get(info, :name),
      description: Map.get(info, :description, ""),
      ordered: true,
      members: members,
      config: config
    }
  end
end
