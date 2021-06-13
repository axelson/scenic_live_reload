# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

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
