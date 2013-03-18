ioclient = require('socket.io-client')

module.exports = (ioServer, serverAddress, clientNum, callback) ->

  serverSockets = []
  clientSockets = []
  currentClient = 0

  gotClientConnection = (socket) ->
    serverSockets.push(socket)
    connectNextClient()

  connectNextClient = () ->
    if currentClient > clientNum then callback('Something went wrong')
    else if currentClient == clientNum then finish()
    else
      currentClient += 1
      newClient = ioclient.connect(serverAddress, {'force new connection': true})
      clientSockets.push(newClient)

  finish = () ->
    ioServer.removeListener('connection' , gotClientConnection)
    callback(null, [ clientSockets, serverSockets ])


  ioServer.on('connection', gotClientConnection)
  connectNextClient()

  