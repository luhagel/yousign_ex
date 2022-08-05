defmodule Yousign.API.Members do
  import Yousign.API
  import Yousign.Request

  alias Yousign.Config

  def list, do: make_request(:get, "members")

  def get_signature_url(member_id) when is_binary(member_id) do
    signature_ui_id = Config.resolve(:signature_ui_id, nil)

    if is_binary(signature_ui_id) do
      "#{get_web_url()}/procedure/sign?members=#{member_id}&signatureUi=/signature_uis/#{signature_ui_id}"
    else
      "#{get_web_url()}/procedure/sign?members=#{member_id}"
    end
  end
end
