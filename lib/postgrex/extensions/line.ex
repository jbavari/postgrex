defmodule Postgrex.Extensions.Line do
  @moduledoc false
  alias Postgrex.TypeInfo
  use Postgrex.BinaryExtension, send: "line_send"
  import Postgrex.BinaryUtils
  require Decimal

  def encode(%TypeInfo{type: "line", send: "line_send"}, %Postgrex.Line{} = line, _, _),
    do: encode_line(line)

  def decode(%TypeInfo{type: "line"}, binary, _, _),
    do: decode_line(binary)

  ## Helpers
  defp decode_line(<<a :: float64, b :: float64, c :: float64>>) do
    %Postgrex.Line{a: a, b: b, c: c}
  end

  defp encode_line(%Postgrex.Line{a: a, b: b, c: c}),
    do: <<a :: float64, b :: float64, c :: float64>>
end
