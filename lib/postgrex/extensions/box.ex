defmodule Postgrex.Extensions.Box do
  @moduledoc false
  alias Postgrex.TypeInfo
  use Postgrex.BinaryExtension, send: "box_send"
  import Postgrex.BinaryUtils
  require Decimal

  def encode(%TypeInfo{type: "box", send: "box_send"}, %Postgrex.Box{} = box, _, _),
    do: encode_box(box)

  def decode(%TypeInfo{type: "box"}, binary, _, _),
    do: decode_box(binary)

  defp encode_box(%Postgrex.Box{a: point1, b: point2}),
    do: <<point1.x :: float64, point1.y :: float64, point2.x :: float64, point2.y :: float64>>

  defp decode_box(<<x1 :: float64, y1 :: float64, x2 :: float64, y2 :: float64>>) do
    %Postgrex.Box{a: %Postgrex.Point{x: x1, y: y1}, b: %Postgrex.Point{x: x2, y: y2}}
  end
end
