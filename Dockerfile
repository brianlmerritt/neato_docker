FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt update && apt install -y locales
RUN locale-gen en_GB en_GB.UTF-8
RUN update-locale LC_ALL=en_GB.UTF-8 LANG=en_GB.UTF-8
RUN LANG=en_GB.UTF-8
#ENV LANG en_GB.UTF-8
#ENV LC_ALL en_GB.UTF-8

RUN apt update && apt install -y curl gnupg2 lsb-release git
RUN apt-get install -y build-essential

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt install -y ros-foxy-desktop
RUN apt install -y ros-foxy-navigation2
RUN apt install -y ros-foxy-ecl-config ros-foxy-ecl-tools
RUN apt install -y librostest-dev python3-rostest
#RUN apt install -y ros-foxy-test-interface-files ros-foxy-test-msgs ros-foxy-test-launch-system-modes
RUN apt install -y ros-foxy-ros-testing
RUN apt install -y ros-foxy-nav2-behavior-tree ros-foxy-behaviortree-cpp-v3

WORKDIR /root/dev_ws/src
RUN git clone https://github.com/cpeavy2/botvac_node.git
RUN git clone https://github.com/cpeavy2/neato_robot.git
RUN git clone https://github.com/kobuki-base/cmd_vel_mux.git
RUN git clone https://github.com/kobuki-base/velocity_smoother.git
#RUN git clone -b foxy-devel https://github.com/ros-planning/navigation2.git
WORKDIR /root/dev_ws


#RUN apt-get install python3-rosdep2 -y
#To create a more minimal version, comment out ros-foxy-desktop install above and uncomment below
#RUN rosdep init
#RUN rosdep update
#RUN rosdep install -i --from-path src --rosdistro foxy -y
RUN apt install python3-colcon-common-extensions -y

RUN source /opt/ros/foxy/setup.bash && colcon build
#RUN ros2 launch botvac_node test.py
#RUN colcon build

COPY ros2_entrypoint.sh /root/.
ENTRYPOINT ["/root/ros2_entrypoint.sh"]
CMD ["bash"]
