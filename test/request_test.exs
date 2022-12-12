defmodule YousignTest.Request do
  use ExUnit.Case

  alias Yousign.Request

  test "base_url/0" do
    assert Request.base_url(false) == "https://api.yousign.app/v3"

    # test sandbox
    assert Request.base_url(true) == "https://api-sandbox.yousign.app/v3"
  end

  test "web_url/0" do
    assert Request.web_url(false) == "https://webapp.yousign.com"
    # test sandbox
    assert Request.web_url(true) == "https://staging-webapp.yousign.com"
  end
end
