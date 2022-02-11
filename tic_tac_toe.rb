#classes: Game, Player, Board
#methods for Game: check win, next turn
#methods for Player: play, 
#methods for Board: show board

class Game
    def initialize
        start_game()

    end

    def start_game
        @board = Board.new()
        @player_one = Player.new("one (X)", @board)
        puts
        @player_two = Player.new("two (O)", @board)
        puts

        @board.show


        next_turn()
    end

    def next_turn

        while @board.check_won? == false
            @board.change_tile(@player_one.play, "x")
            @board.show

            break if @board.check_won? == true

            @board.change_tile(@player_two.play, "o")
            @board.show

        end
    end
end

class Board < Game
    def initialize
        @board = Array.new(3) {Array.new(3, "_")}
    end

    def show
        @board.each do |line|
            puts line.join(" ")
        end
        puts
    end

    def check_won?
        if @board.any? { |line| line[0] == line[1] && line[1] == line[2] && line[0] != "_"}
            true
        elsif @board[0][0] == @board[1][0] && @board[1][0] == @board[2][0] && @board[0][0] != "_"
            true
        elsif @board[0][1] == @board[1][1] && @board[1][1] == @board[2][1] && @board[0][1] != "_"
            true
        elsif @board[0][2] == @board[1][2] && @board[1][2] == @board[2][2] && @board[0][2] != "_"
            true
        elsif @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] != "_"
            true
        elsif @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] != "_"
            true
        else
            false
        end
    end

    def change_tile(position, tile)
        @board[position[0]-1][position[1]-1] = tile
    end

    def check_empty?(position)
        if @board[position[0]-1][position[1]-1] == "_"
            true
        else
            false
        end
    end
end

class Player < Game
    def initialize(count, board)
        player_name(count)
        @board = board
    end

    def player_name(count)
        puts "Player #{count} name:"
        @name = "ac" #gets
    end

    def play
        puts "Player #{@name}"
        turn = true
        position = []
        while turn == true
            position = gets.chomp.strip.split(",")
            if position.any? { |ans| ans.strip.to_i.to_s != ans.strip } || position.size != 2 #checks whether the input is a number
                puts "Wrong input! Try 'X, Y'"
            else
                position.map! { |ans| ans.strip.to_i } 
                if position.all? { |ans| ans == 1 || ans == 2 || ans == 3 } # checks whether the input is between 1-3
                    if @board.check_empty?(position)
                        turn = false
                    else
                        puts "That position is already occupied"
                    end
                else
                    puts "Wrong input! Try a number between 1 and 3"
                end
            end
        end
        position
    end
end

new_game = Game.new()