# Socket.io pool for testing

This module creates a set of sockets and returns both the client-side and server-side sockets. It is mainly meant for testing socket.io apps.

# Installing

    npm install socket.io-test-pool


# Usage

    var createsocketiopool = require('../src/socket.io-test-pool');
    createsocketiopool(socketioServer, serverAddress, numberOfSockets, callback);


# Example

    var createsocketiopool = require('socket.io-test-pool');
    
    var ioserver = require('socket.io').listen(3006);
    
    createsocketiopool(ioserver, 'http://localhost:3006', 4, function(err, result) {
    
        clientSockets = result[0];
        serverSockets = result[1];
        serverSockets[2].on('hello', function() { console.log('it works!'); });
        clientSockets[2].emit('hello');
    
    });

