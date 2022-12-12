defmodule Yousign.SignatureRequestInput do
  @moduledoc """
  Models a Yousign request signature input.
  See: https://developers.yousign.com/reference/post-signature_requests
  """
  use TypedStruct

  @type delivery_mode :: :email | :none
  @type reminder_settings :: %{
          interval_in_days: non_neg_integer(),
          max_occurrences: non_neg_integer()
        }
  @type signature_level ::
          :electronic_signature
          | :advanced_electronic_signature
          | :electronic_signature_with_qualified_certificate
          | :qualified_electronic_signature_mode_1
  @type signature_authentication_mode :: :otp_sms | :otp_email | :no_otp | nil
  @type redirect_urls :: %{success: String.t() | nil, error: String.t() | nil} | nil
  @type field_input ::
          %{
            type: :signature,
            document_id: String.t(),
            width: non_neg_integer() | nil,
            height: non_neg_integer() | nil,
            page: non_neg_integer(),
            x: non_neg_integer(),
            y: non_neg_integer()
          }
          | %{
              type: :mention,
              document_id: String.t(),
              width: non_neg_integer() | nil,
              page: non_neg_integer(),
              x: non_neg_integer(),
              y: non_neg_integer(),
              mention: String.t()
            }
          | %{
              type: :text,
              document_id: String.t(),
              width: non_neg_integer() | nil,
              height: non_neg_integer() | nil,
              page: non_neg_integer(),
              x: non_neg_integer(),
              y: non_neg_integer(),
              max_length: non_neg_integer(),
              instruction: String.t(),
              optional: boolean()
            }
          | %{
              type: :checkbox,
              document_id: String.t(),
              page: non_neg_integer(),
              x: non_neg_integer(),
              y: non_neg_integer(),
              optional: boolean(),
              name: String.t() | nil,
              checked: boolean()
            }
  @type signer_info :: %{
          first_name: String.t(),
          last_name: String.t(),
          email: String.t(),
          phone_number: String.t() | nil,
          locale: :en | :de | :fr | :it | :es | :pl | :nl
        }
  @type signer_from_info :: %{
          info: signer_info(),
          fields: list(field_input()),
          signature_level: signature_level(),
          signature_authentication_mode: signature_authentication_mode(),
          redirect_urls: redirect_urls()
        }

  @derive Jason.Encoder
  typedstruct do
    field :name, String.t(), enforce: true
    field :delivery_mode, delivery_mode(), enforce: true
    field :ordered_signers, boolean() | nil, default: nil
    field :reminder_settings, reminder_settings() | nil, default: nil
    field :timezone, String.t() | nil, default: nil
    field :email_custom_note, String.t() | nil, default: nil
    field :expiration_date, DateTime.t() | nil, default: nil
    field :template_id, String.t() | nil, default: nil
    field :external_id, String.t() | nil, default: nil
    field :branding_id, String.t() | nil, default: nil
    field :documents, list(String.t()), enforce: true
    field :signers, list(signer_from_info()), enforce: true
  end
end
