defmodule Postgrex.Extensions.Point do
  @moduledoc false
  alias Postgrex.TypeInfo
  use Postgrex.BinaryExtension, send: "point_send"
  import Postgrex.BinaryUtils
  require Decimal

  def encode(%TypeInfo{type: "point"}, %Postgrex.Point{} = point, _, _),
    do: encode_point(point)

  def decode(%TypeInfo{type: "point"}, binary, _, _),
    do: decode_point(binary)

  ## Helpers

  defp encode_point(%Postgrex.Point{x: x, y: y}),
    do: <<x :: float64, y :: float64>>

  defp decode_point(<<x::float64, y::float64>>) do
    %Postgrex.Point{x: x, y: y}
  end
end
