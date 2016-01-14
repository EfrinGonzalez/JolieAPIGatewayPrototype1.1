Running the Jolie
Once the API Gateway is running, the server will automatically run. So, in order to try the server out, the client must be run in other command line screen by writing jolie client.ol


About the Java services within Jolie:
To compile the java classes you must do: 
javac -cp c:/Jolie/jolie.jar MyConsole.java;
javac -cp c:/Jolie/jolie.jar Twice.java;

Once they are converted to class: 
jar cvf MyConsole.jar MyConsole.class
jar cvf Twice.jar Twice.class

Always check the path when compiling or converting to a .jar files.