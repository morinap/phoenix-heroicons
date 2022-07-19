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

  describe "icon/1" do
    defp rendered_icon(assigns) do
      assigns
      |> PhoenixHeroicons.icon()
      |> Phoenix.HTML.Safe.to_iodata()
      |> IO.iodata_to_binary()
    end

    test "raises when missing name assign" do
      assert_raise ArgumentError, ~r/missing :name assign/, fn ->
        rendered_icon(%{})
      end
    end

    test "returns SVG content for known icon" do
      content = rendered_icon(%{name: "bell"})

      assert String.match?(content, ~r/^<svg/)
    end

    test "adds specified attributes to the SVG" do
      content = rendered_icon(%{name: "bell", class: "test-class", foo: "bar"})

      assert String.match?(content, ~r/class="test-class"/)
      assert String.match?(content, ~r/foo="bar"/)
    end

    test "renders empty html for unknown icon" do
      assert "" == rendered_icon(%{name: "foo"})
    end
  end
end
