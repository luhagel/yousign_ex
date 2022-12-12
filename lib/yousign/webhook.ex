defmodule Yousign.Webhook do
  @moduledoc """
  A webhook payload
  """

  use TypedStruct

  typedstruct do
    field :event_id, String.t(), enforce: true
    field :event_name, String.t(), enforce: true
    field :event_time, String.t(), enforce: true
    field :subscription_id, String.t(), enforce: true
    field :subscription_description, String.t(), enforce: true
    field :sandbox, boolean(), enforce: true
    field :data, map(), enforce: true
  end
end
