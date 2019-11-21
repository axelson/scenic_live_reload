defmodule ScenicLiveReload.Private.GetScenePids do
  @moduledoc """
  WARNING: Relies on semi-private scenic API's

  Allows you to get the PID's of the current scene. There is a proposal to
  create a private api for this functionality that has been discussed at:
  https://github.com/boydm/scenic_new/pull/19
  """

  def scene_pids(viewports) do
    Enum.map(viewports, fn config ->
      viewport_name = config.name
      {:ok, %{root_scene_pid: root_scene_pid}} = Scenic.ViewPort.info(viewport_name)
      {:ok, root_scene_pid}
    end)
  end
end
