#!/bin/bash
trap : SIGTERM SIGINT

SCRIPT_PATH="$(readlink -f "$0")"
WORKSPACE_DIR="$(dirname "$(dirname "$(dirname "$SCRIPT_PATH")")")"
echo "Workspace directory is: ${WORKSPACE_DIR}"

gnome-terminal --tab -- bash -c "roscore ; exec bash"
sleep 1s

gnome-terminal -t "marsim" --tab -- bash -c "source ${WORKSPACE_DIR}/devel/setup.bash && \
                                  roslaunch test_interface single_drone_avia.launch; exec bash"

# gnome-terminal -t "autonomous_exploration_development_environment" --tab -- bash -c "source ${WORKSPACE_DIR}/devel/setup.bash && \
#                                   roslaunch vehicle_simulator system_garage.launch; exec bash"

gnome-terminal -t "tare_planner" --tab -- bash -c "source ${WORKSPACE_DIR}/devel/setup.bash && \
                                    roslaunch tare_planner explore_MARSIM_library.launch; exec bash;"

gnome-terminal -t "ego_planner" --tab -- bash -c "source ${WORKSPACE_DIR}/devel/setup.bash && \
                                    roslaunch ego_planner simple_run.launch; exec bash;"


