defmodule PhoenixHeroiconsTest do
  use ExUnit.Case

  describe "svg/2" do
    test "returns SVG content for known icon" do
      assert {:safe, content} = PhoenixHeroicons.svg("outline/bell")

      assert String.match?(content, ~r/^<svg/)
    end

    test "adds specified attributes to the SVG" do
      assert {:safe, content} =
               PhoenixHeroicons.svg("outline/bell", class: "test-class", foo: "bar")

      assert String.match?(content, ~r/class="test-class"/)
      assert String.match?(content, ~r/foo="bar"/)
    end

    test "returns nil for unknown icon" do
      assert nil == PhoenixHeroicons.svg("foo")
    end
  end
end
