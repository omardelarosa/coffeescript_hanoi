class RecursiveHanoi

    #this is just like "initialize" in ruby
    constructor: (@discs) ->
        console.log("Playing with #{@discs} discs")

        @pegs = {
            from: [],
            to: [],
            pivot: []
        }

        for i in [@discs..1]
          # [4,3,2,1]
            @pegs.from.push(i)

    shift: (disc,pegs={}) ->
        pegs["to"].push(pegs["from"].pop())
        pegs

    move: (n, pegs={}) ->
        # #debug 
        # console.log(pegs)
        if n > 1
            #make options hash
            options = {
                    from: pegs.from,
                    to: pegs.pivot,
                    pivot: pegs.to
                }

            new_discs = n-1
            this.move(new_discs,options)

        #move pegs
        if @pegs.to.length != @discs
            this.shift(1,pegs)

        this.print_state()

        #recurse again, but with shifted pegs
        #i.e. from becomes formert pivot_peg, to becomes former pivot peg, pivot becomes the start peg

        if n > 1
            #make options hash of shifted pegs
            options = {
                    from: pegs.pivot,
                    to: pegs.to,
                    pivot: pegs.from
                }
            #recursive call
            new_discs = n-1
            this.move(new_discs,options)
            # move((n-1),options)

    solve: ->
        #display pegs initial state
        this.print_state("Initial State")

        @move(this.discs,this.pegs)

        #display pegs final state
        this.print_state("Final State")

    print_state: (state_desc_string="Current State")->
        #display pegs initial state
        content_string = "
                  <div class='state'>
                  <hr>
                  #{state_desc_string}<br>
                  Peg A: #{@pegs.from.toString()}<br>
                  Peg B: #{@pegs.to.toString()}<br>
                  Peg C: #{@pegs.pivot.toString()}<br>
                  <hr>
                  </div>"
        $('#display_area').append(content_string)

#run a game of 8 discs, make it a global object
window.game = new RecursiveHanoi 4
game.solve()