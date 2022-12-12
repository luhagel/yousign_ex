defmodule Yousign.DocumentInput do
  @doc """
  Input required to create a new document
  """

  use TypedStruct

  alias Yousign.Document

  typedstruct do
    field :file, any(), enforce: true
    field :nature, Document.document_nature(), enforce: true
    field :password, String.t() | nil, default: nil
    field :parse_anchors, boolean() | nil, default: nil
    field :initials, any(), default: nil
  end
end
