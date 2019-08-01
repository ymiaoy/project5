#Environment Set-up

 1.Make a workespace
	
	$ mkdir -p HomeServiceRobot/src
	$ cd HomeServiceRobot/src
	$ catkin_init_workspace 

 2.Clone this repository

    $ git clone https://github.com/ymiaoy/Home-service-robot ../src/
	$ cd ..
	$ catkin_make
	
 3.It's necessary to source .sh file in every new terminal
	
	$ source src/scripts/set_environment.sh $TERMINAL
 
 4.Simple test
 
 	$ ./src/scripts/launch.sh $TERMINAL
 	
    As a result, gazebo and rviz should open and roscore will be up and running.

#Mapping

 1.It's as same as above. If you open a new terminal, it should be sourced again:
	 	
	$ source src/scripts/set_environment.sh $TERMINAL
	$ ./src/scripts/test_slam.sh $TERMINAL  
	
	As a result, it's will launch:

		1).Turtlebot inside the world in src/world.
		2).gmapping demo
		3).rviz with a configuration that will show navigation
		4).keyboard_teleop, a node that will allow you to command the turtlebot with your keyboard

	In order to map a different world, edit "src/scripts/test_slam.sh" file,
	substituting  the path to your .world file after world_file:=.
	
	Drive the turtlebot around for a while and when you are happy with the map, before terminating gmapping node, use the following command in a new terminal (setting it up as explained above):
	
	$ rosrun map_server map_saver -f src/map/map
	
	Do not include any extension, as this command will create both the .pgm file with the map and the .yaml configuration file.

#Localization and Navigation

	Now that we created a map for our world, our robot will be able to localize itself in the map and also navigate to any goal in its reach. In the case of the localization, we are using AMCL (Adaptive Monte Carlo Localization). For navigation, we rely on ROS Navigation stack, which is based on Dijkstra's algorithm. To see it in action:

 1. 
 	$ source src/scripts/set_environment.sh $TERMINAL
	$ ./src/scripts/test_navigation.sh $TERMINAL
   
    In the case we are using another world, we would only need to edit src/scripts/test_navigation.sh $TERMINAL substituting the path to the target .world file after world_file:= and the location of the configuration for the map we created in the previous section after map_file:=. In this case, we need to explicitely add the extension .yaml to the command.

	Now go to the xterminal that is running rviz, select 2D Nav Goal and locate it wherever in the map you want the robot to move.

#Ros node
There are two nodes: "pick_objects" and "add_markers"

Instead of adding the goals manually, we would like to have a node that does this for us. pick_objects will command our robot to:

	1).Go to a pick-up location in our map
	2).Wait for 5 seconds (simulating picking up a virtual object)
	3).Go to a drop-off location in our map
	4).Inform us at every stage

To test this node, we need to run:

	$ chmod +x src/scripts/pick_objects.sh $TERMINAL
	$ ./src/scripts/pick_objects.sh $TERMINAL


