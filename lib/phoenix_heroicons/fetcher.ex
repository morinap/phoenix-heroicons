defmodule PhoenixHeroicons.Fetcher do
  @moduledoc false

  # https://github.com/tailwindlabs/heroicons/releases
  @target_heroicon_version "1.0.6"

  defmacro __before_compile__(_env) do
    version = @target_heroicon_version
    url = "https://github.com/tailwindlabs/heroicons/archive/refs/tags/v#{version}.zip"
    tmp_working_path = "tmp/work"

    # Fetch the Heroicons release and extract the zip to our working directory
    binary = PhoenixHeroicons.Util.fetch_body!(url)
    File.mkdir_p!(Path.dirname(tmp_working_path))
    :zip.unzip(binary, [{:cwd, tmp_working_path}])

    # Iterate and store all of the "optimized" SVGs.
    # We will parse them with Floki and store them as a parsed tag structure. This allows us to dynamically apply
    # attributes, such as `class`, at run time when the SVG is rendered.
    icons =
      "#{tmp_working_path}/**/optimized/**/*.svg"
      |> Path.wildcard()
      |> Enum.sort()
      |> Enum.map(&Path.relative_to_cwd/1)
      |> Enum.map(fn path ->
        contents =
          path
          |> File.read!()
          |> Floki.parse_fragment!()

        [category, name] =
          path
          |> Path.split()
          |> Enum.drop(4)

        name = String.replace_suffix(name, ".svg", "")

        {"#{category}/#{name}", contents}
      end)
      |> Enum.into(%{})

    # Cleanup temp directory
    File.rm_rf!(Path.dirname(tmp_working_path))

    quote do
      @icons unquote(Macro.escape(icons))

      defp icon_definitions, do: @icons
    end
  end

  defmacro __using__(_opts) do
    quote do
      @before_compile PhoenixHeroicons.Fetcher
    end
  end
end
