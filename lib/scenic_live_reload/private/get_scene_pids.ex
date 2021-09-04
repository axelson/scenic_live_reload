defmodule ScenicLiveReload.Private.GetScenePids do
  @moduledoc """
  WARNING: Relies on semi-private scenic API's

  Allows you to get the PID's of the current scene. There is a proposal to
  create a private api for this functionality that has been discussed at:
  https://github.com/boydm/scenic_new/pull/19
  """

  def scene_pids(viewports) do
    Enum.map(viewports, fn config ->
      viewport_name = Keyword.get(config, :name)
      {:ok, viewport} = Scenic.ViewPort.info(viewport_name)
      %{scene: {scene, param}} = :sys.get_state(viewport.pid)
      Scenic.ViewPort.set_root(viewport, scene, param)

      # {:ok, %{pid: viewport_pid}} = Scenic.ViewPort.info(viewport_name)
      # %{scene_sup: scene_sup_pid} = :sys.get_state(viewport_pid)
      # [{_, root_scene_pid, _, _}] = DynamicSupervisor.which_children(scene_sup_pid)
      # {:ok, root_scene_pid}
    end)
  end
end
