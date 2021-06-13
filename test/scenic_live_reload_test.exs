defmodule ScenicLiveReloadTest do
  use ExUnit.Case
  doctest ScenicLiveReload

  test "README.md version is up to date" do
    app = :scenic_live_reload
    app_version = Application.spec(app, :vsn) |> to_string()
    readme = File.read!("README.md")
    [_, readme_version] = Regex.run(~r/{:#{app}, "(.+)", only: :dev}/, readme)
    assert Version.match?(app_version, readme_version)
  end
end
