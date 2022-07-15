defmodule PhoenixHeroicons do
  @moduledoc """
  Phoenix Heroicons is a package that will install the source SVGs for the [Heroicons](https://heroicons.com/) library
  and provide an Elixir module for rendering those SVGs inside of [Phoenix](https://www.phoenixframework.org/) templates.

  ## Usage
  To render a Heroicon within an `eex` template, simply call `PhoenixHeroicons.svg` with the icon's type and name, for
  example: `outline/bell`. See `PhoenixHeroicons.svg`.
  """

  use PhoenixHeroicons.Fetcher

  @doc """
  Gets an HTML-safe SVG for use in a Phoenix template for the given Heroicon. Any specified attributes will overwrite
  attributes on the root `svg` element.

  Returns `{:safe, <html content>}` if the icon exists or `nil` if it does not.

  ## Examples

    ```
    iex> PhoenixHeroicons.svg("outline/bell")
    {:safe, "<svg xmlns=\\"http://www.w3.org/2000/svg\\" fill=\\"none\\" viewbox=\\"0 0 24 24\\" stroke-width=\\"2\\" stroke=\\"currentColor\\" aria-hidden=\\"true\\">...</svg>"}
    ```

    ```
    iex> PhoenixHeroicons.svg("outline/bell", class: "text-red-500")
    {:safe, "<svg class=\\"text-red-500\\" xmlns=\\"http://www.w3.org/2000/svg\\" fill=\\"none\\" viewbox=\\"0 0 24 24\\" stroke-width=\\"2\\" stroke=\\"currentColor\\" aria-hidden=\\"true\\">...</svg>"}
    ```


  """
  @spec svg(name :: String.t(), attrs :: Keyword.t()) :: {:safe, String.t()} | nil
  def svg(name, attrs \\ []) do
    case Map.get(icon_definitions(), name) do
      nil ->
        nil

      icon ->
        Enum.reduce(attrs, icon, fn {key, val}, icon ->
          key = if is_atom(key), do: Atom.to_string(key), else: key
          Floki.attr(icon, "svg", key, fn _ -> val end)
        end)
        |> Floki.raw_html()
        |> Phoenix.HTML.raw()
    end
  end
end
