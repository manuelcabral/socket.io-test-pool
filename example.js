var createsocketiopool = require('socket.io-test-pool');

var ioserver = require('socket.io').listen(3006);

createsocketiopool(ioserver, 'http://localhost:3006', 4, function(err, result) {

  clientSockets = result[0];
  serverSockets = result[1];
  serverSockets[2].on('hello', function() { console.log('it works!'); });
  clientSockets[2].emit('hello');

});
