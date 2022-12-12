defmodule Yousign.Document do
  @doc """
  Models a document to be signed
  """

  use TypedStruct

  @type document_nature :: :attachment | :signable_document

  typedstruct do
  end
end
