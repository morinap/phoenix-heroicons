# PhoenixHeroicons

Phoenix Heroicons is a package that will install the source SVGs for the [Heroicons](https://heroicons.com/) library
and provide an Elixir module for rendering those SVGs inside of [Phoenix](https://www.phoenixframework.org/) templates.

Documentation is [available on Hexdocs](https://hexdocs.pm/phoenix_heroicons/0.2.0/PhoenixHeroicons.html).

## Installation

The package is [avaialble in Hex](https://hex.pm/packages/phoenix_heroicons/0.2.0) and can be installed by adding
`phoenix_heroicons` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_heroicons, "~> 0.2.0"}
  ]
end
```

## Usage

To render a Heroicon using in an `heex` template, using a functional component, import `PhoenixHeroicons` into your view
module and then write:

```
<.icon name="bell" outline/>
```

If you want to render a Heroicon without using a functional component, perhaps inside an `eex` template, simply call
`PhoenixHeroicons.svg` with the icon's type and name, for example: `outline/bell`:

```
iex> PhoenixHeroicons.svg("outline/bell")
    {:safe, "<svg xmlns=\\"http://www.w3.org/2000/svg\\" fill=\\"none\\" viewbox=\\"0 0 24 24\\" stroke-width=\\"2\\" stroke=\\"currentColor\\" aria-hidden=\\"true\\">...</svg>"}
```
