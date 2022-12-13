defmodule Yousign.Document do
  @doc """
  Models a document to be signed
  """

  use TypedStruct

  @type document_nature :: :attachment | :signable_document
  @type intials :: %{
          alignement: :left | :center | :right,
          y: non_neg_integer()
        }

  typedstruct do
    field :id, String.t(), enforce: true
    field :filename, String.t(), enforce: true
    field :nature, document_nature(), enforce: true
    field :content_type, String.t(), enforce: true
    field :sha256, String.t(), enforce: true
    field :is_protected, boolean(), enforce: true
    field :is_signed, boolean(), enforce: true
    field :created_at, DateTime.t(), enforce: true
    field :total_pages, non_neg_integer(), enforce: true
    field :is_locked, boolean(), enforce: true
    field :initials, intials(), enforce: true
    field :total_anchors, non_neg_integer(), enforce: true
  end
end
