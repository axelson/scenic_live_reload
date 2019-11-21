# ScenicLiveReload

A live reloader for Scenic. Once configured, when you edit a file the current
root scene will be killed, when it is restarted it will use any new code
currently in the running beam instance.

How it works:
* Uses [exsync](https://github.com/axelson/exsync) to watch the file system 
* When you edit a file with your editor, exsync recompiles and reloads that beam file
* `exsync` notifies `scenic_live_reload` that files were reloaded
* `scenic_live_reload` kills the currently displayed root scene
* The OTP Supervisor for that scene restarts the scene with the updated code

# Demo

In this demo I replace the text "World" with "Scenic", then change the color of
the text to purple. Next I change the shape of the bezier line.

[![Screencast Demo](./demo.gif)](https://raw.githubusercontent.com/axelson/scenic-starter-pack/master/demo.gif)

Note: the code running in the demo can be found at https://github.com/axelson/scenic_live_reload_demo

See also: [scenic-starter-pack](https://github.com/axelson/scenic-starter-pack)

# Installation

Add `scenic_live_reload` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    ...
    {:scenic_live_reload, "~> 0.2", only: :dev},
  ]
end
```

Add this configuration to your `config.exs`:
```
case Mix.env() do
  :dev ->
    config :exsync,
      reload_timeout: 75,
      reload_callback: {ScenicLiveReload, :reload_current_scene, []}

  _ ->
    nil
end
```

Add `ScenicLiveReload` to your supervision tree, passing in your viewport configuration

```
main_viewport_config = Application.get_env(:pomodoro, :viewport)

children = [
  # other children
  {ScenicLiveReload, viewports: [main_viewport_config]}
]
```

Then start your application with `mix scenic.run`, edit a file with your editor, and then you should see your change reflected.

# Development

NOTE: This currently relies on a private scenic api to get the root scene which may change in future Scenic releases
