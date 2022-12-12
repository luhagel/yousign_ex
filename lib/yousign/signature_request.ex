defmodule Yousign.SignatureRequest do
  @moduledoc """
  Models a Yousign request signature.
  See: https://developers.yousign.com/reference/get-signature_requests-signaturerequestid
  """
  use TypedStruct

  alias Yousign.Document

  @type signature_request_status ::
          :draft | :ongoing | :done | :deleted | :expired | :canceled | :approval | :rejected
  @type delivery_mode :: :email | :none
  @type source ::
          :public_api
          | :connector_hubspot_api
          | :connector_salesforce_api
          | :connector_google_api
          | :connector_zapier_api
  @type reminder_settings :: %{
          interval_in_days: non_neg_integer(),
          max_occurrences: non_neg_integer()
        }
  @type signer_status ::
          :initiated
          | :notified
          | :identified
          | :verifying
          | :consent_given
          | :verified
          | :verification_failed
          | :processing
          | :signed
  @type approver_status :: :initiated | :notified | :approved | :rejected

  typedstruct do
    field :id, String.t(), enforce: true
    field :status, signature_request_status(), enforce: true
    field :name, String.t(), enforce: true
    field :delivery_mode, delivery_mode(), enforce: true
    field :created_at, DateTime.t(), enforce: true
    field :ordered_signers, boolean() | nil, default: nil
    field :reminder_settings, reminder_settings(), enforce: true
    field :timezone, String.t() | nil, default: nil
    field :email_custom_note, String.t() | nil, default: nil
    field :expiration_date, DateTime.t() | nil, default: nil
    field :source, source(), enforce: true
    field :signers, list(%{id: String.t(), status: signer_status()}), enforce: true
    field :approvers, list(%{id: String.t(), status: approver_status()}), enforce: true
    field :documents, list(%{id: String.t(), nature: Document.document_nature()}), enforce: true
    field :sender, %{id: String.t(), email: String.t()}, enforce: true
    field :external_id, String.t(), enforce: true
    field :branding_id, String.t(), enforce: true
  end
end
