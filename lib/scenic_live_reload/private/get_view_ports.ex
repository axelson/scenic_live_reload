defmodule ScenicLiveReload.Private.GetViewPorts do
  @moduledoc """
  WARNING: Relies on private scenic API's

  Allows you to get the PID's of the currently running viewports. There is a
  proposal to create a private api for this functionality that has been
  discussed at:
  https://github.com/boydm/scenic_new/pull/19
  """

  @view_port_supervisor_name :scenic_viewports

  def view_port_pids do
    children = DynamicSupervisor.which_children(@view_port_supervisor_name)

    Enum.map(children, fn child ->
      {_, root_scene_pid, _, _} = child
      root_scene_pid
    end)
  end
end
