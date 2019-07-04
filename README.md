# ScenicLiveReload

A live reloader for Scenic. Once configured, when you edit a file the current root scene will be killed, when it is restarted it will use any new code currently in the running beam instance.

Typically used with [exsync](https://github.com/falood/exsync) to watch the file system and recompile and reload the beam files.

Example configuration:
```
case Mix.env() do
  :dev ->
    config :exsync,
      reload_timeout: 75,
      reload_callback: {ScenicLiveReload, :reload_current_scene, []}

  _ -> nil
end
```

TODO:
- [ ] Write nicer description
- [ ] Request new exsync release
- [ ] Publish to hex
- [ ] Announce

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `scenic_live_reload` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:scenic_live_reload, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/scenic_live_reload](https://hexdocs.pm/scenic_live_reload).

