defmodule Yousign.Fields do
  @moduledoc """
  Helpers to quickly create anchor fields
  """

  @doc """
  Creates a new signature field
  """
  @spec signature_field(non_neg_integer(), non_neg_integer(), non_neg_integer()) :: String.t()
  def signature_field(signer_index, width, height) do
    """
    {{s#{signer_index}|signature|#{width}|#{height}}}
    """
  end

  @doc """
  Creates a new mention field
  """
  @spec mention_field(non_neg_integer(), String.t()) :: String.t()
  def mention_field(signer_index, mention) do
    """
    {{s#{signer_index}|mention|#{mention}}}
    """
  end

  @doc """
  Creates a new checkbox field
  """
  @spec checkbox_field(non_neg_integer(), :t | :f, :t | :f, String.t()) ::
          String.t()
  def checkbox_field(signer_index, optional, checked, name) do
    """
    {{s#{signer_index}|checkbox|#{optional}|#{checked}#{name}}}
    """
  end

  @doc """
  Creates a new text field
  """
  @spec text_field(
          non_neg_integer(),
          non_neg_integer(),
          non_neg_integer(),
          neg_integer(),
          String.t(),
          String.t(),
          :t | :f
        ) :: String.t()
  def text_field(signer_index, max_length, width, height, question, instruction, optional) do
    """
    {{s#{signer_index}|text|#{max_length}|#{width}|#{height}|#{question}|#{instruction}|#{optional}}}
    """
  end
end
