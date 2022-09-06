defmodule ScenicLiveReload.Private.FetchScenicInfo do
  @moduledoc """
  WARNING: Relies on private scenic API's

  Allows you to get the PID's of the currently running viewports. There is a
  proposal to create a private api for this functionality that has been
  discussed at:
  https://github.com/boydm/scenic_new/pull/19

  Also allows getting information about the current scene
  """

  def view_port_pids do
    # WARNING: the `:scenic_viewports` supervisor is an internal Scenic
    # implementation detail
    children = DynamicSupervisor.which_children(:scenic_viewports)

    Enum.map(children, fn child ->
      {_, root_scene_pid, _, _} = child
      root_scene_pid
    end)
  end

  def get_current_scene(%Scenic.ViewPort{} = view_port) do
    # WARNING: Private API
    %{scene: {scene, params}} = :sys.get_state(view_port.pid)
    {scene, params}
  end
end
