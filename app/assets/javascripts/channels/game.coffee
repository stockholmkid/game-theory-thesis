App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    $('#status').html("Waiting for an other player")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch data.action
      when "game_start"
        $('#status').html("Player found")
        App.gamePlay = new Game('#game-container', data.msg)

      when "take_turn"
        App.gamePlay.move data.move
        $('#leadero').html(data.move)

      when "new_game"
        App.gamePlay.newGame()

      when "opponent_withdraw"
        $('#status').html("Round has ended: click 'new opponent' to start the next round!")
        $('#new-match').removeClass('hidden');

  take_turn: (move) ->
    @perform 'take_turn', data: move

  new_game: () ->
    @perform 'new_game'
