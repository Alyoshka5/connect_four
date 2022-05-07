class ConnectFour
    def initialize
        @grid = [[' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ']]
        @turn = 'X'
    end

    def play_game
        game_over = false
        until game_over do
            display_grid()
            puts "#{@turn}'s turn:"
            column = get_column()
            puts column
        end
    end

    def display_grid
        display = @grid.map {|row| "|  " + row.join('  |  ') + "  |" }
        num_line = "\n———0—————1—————2—————3—————4—————5—————6———\n"
        row_line = "\n———————————————————————————————————————————\n"
        puts num_line + display.join(row_line) + row_line
    end

    def get_column
        loop do
            puts "Enter column (0 - 6): "
            column = Integer(gets) rescue false
            if !column 
                puts "Invalid column. Please enter integer from 0 to 6"
            else
                return column
            end
        end
    end
end

game = ConnectFour.new
game.display_grid