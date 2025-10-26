# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [0.3.2] - 2025-10-25

* Fix compilation warning and test with Elixir 1.19 and Erlang/OTP 28

## [0.3.1] - 2022-09-05

* Allow both `reload_current_scene` and `reload_current_scenes`

## [0.3.0] - 2022-09-05

* Updated to work with Scenic 0.11

Breaking changes:
* ScenicLiveReload no longer needs to be added to the list of children in your application
  * Remove ScenicLiveReload from the list of children in your application
* Change the configuration to:

```elixir
case Mix.env() do
  :dev ->
    config :exsync,
      reload_timeout: 150,
      reload_callback: {ScenicLiveReload, :reload_current_scenes, []}

  _ ->
    nil
end
```

## [0.2.2] - 2021-06-13

* Tested with scenic 0.10.5

## [0.2.1] - 2021-06-13

* More restrictive scenic version
  * It is possible that ScenicLiveReload will break on the next Scenic version: https://github.com/boydm/scenic/issues/210

## [0.2.0] - 2019-11-21

Breaking changes:
* Now ScenicLiveReload needs to be added to your supervision tree, passing in
  the viewport
  * This is needed for ScenicLiveReload to be more discerning about which
    process it kills to reset the state of your scene
  * Previously sometimes your scene would fail to reload because one of it's
    child scenes was reloaded first

To upgrade add `ScenicLiveReload` to your supervision tree, passing in your viewport configuration. So in a file like `my_app/application.ex`:

```
main_viewport_config = Application.get_env(:pomodoro, :viewport)

children = [
  # other children
  {ScenicLiveReload, viewports: [main_viewport_config]}
]
```

An example of upgrading can be seen in the official demo application: https://github.com/axelson/scenic_live_reload_demo/pull/1

## [0.1.0] - 2019-09-03

Initial release
