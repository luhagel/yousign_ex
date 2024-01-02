defmodule Yousign.API.Consumption do
  import Yousign.Request

  @doc """
  Get the consumption metrics of the current account.

  ## Examples

      iex> Yousign.API.Consumption.metrics()
      {:ok,
       %{
          simpleSignature: 957,
          advancedSignature: 238,
          serverStamp: 57,
          documentVerification: 12,
          archiving: 66356
      }}
  """
  def metrics, do: make_request(:get, "consumptions/metrics")
end
