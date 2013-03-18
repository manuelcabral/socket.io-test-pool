expect = require('chai').expect
createpool = require('../src/socket.io-test-pool')


ioserver = require('socket.io').listen(3006)


describe 'socket.io-test-pool', ->

  it 'should create a socket pool', (done) ->
    createpool ioserver, 'http://localhost:3006', 4, (err, result) ->
      expect(err).to.be.not.ok
      expect(result).to.be.ok
      expect(result).to.have.length(2)
      expect(result[0]).to.have.length(4)
      expect(result[1]).to.have.length(4)
      done()

  it 'should return matching sockets', (done) ->
    createpool ioserver, 'http://localhost:3006', 4, (err, result) ->
      [ clientSockets, serverSockets ] = result
      serverSockets[0].on 'testEvent', () -> done('Event received by the wrong socket')
      serverSockets[1].on 'testEvent', () -> done('Event received by the wrong socket')
      serverSockets[2].on 'testEvent', () -> done('Event received by the wrong socket')
      serverSockets[3].on 'testEvent', () -> done()
      clientSockets[3].emit 'testEvent'
