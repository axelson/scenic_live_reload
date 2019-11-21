# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

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

## [0.1.0] - 2019-09-03

Initial release
