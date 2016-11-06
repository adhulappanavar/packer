
Thanks to http://blog.terminal.com/getting-started-with-upstart/

1. Create a file node-demo.conf
            description "This is a node-demp upstart Job"
            author "Anil"

            start on runlevel [2345]
            exec NODE_ENV=production
            exec /usr/bin/nodejs /app/index.js


2. Copy the anil-node-demo.conf to /etc/init
$ sudo cp anil-node-demo.conf /etc/init

3. Testing: To avoid any issues, you might want to make sure that the syntax 
    our new test.conf file is OK. In order to do that, 
    we will use the init-checkconf command.

    $ sudo init-checkconf /etc/init/anil-node-demo.conf
    File /etc/init/anil-node-demo.conf: syntax ok


4. Now, we can use the service command to launch our job.

        Syntax:

        sudo service <servicename> <control>  
        For Upstart jobs, the service command can send several 'controls' 
        like start, stop, restart, status, etc

5. Check the status before starting 
    $ sudo service anil-node-demo status
            anil-node-demo stop/waiting


    $ sudo service anil-node-demo start


    $ sudo service anil-node-demo status