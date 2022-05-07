class ConnectFour
    attr_accessor :grid
    def initialize
        @grid = [[' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ']]
        @token = 'X'
    end

    def play_game
        game_over = false
        until game_over do
            display_grid()
            puts "#{@token}'s turn:"
            loop do
                column = get_column()
                break if place_token(column)
            end
            display_grid
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

    def place_token(column, row = 0)
        if @grid[0][column] != ' '
            puts "Column full, choose another column"
            return false
        elsif row == 5 || @grid[row + 1][column] != ' '
            @grid[row][column] = @token
            return true
        end
        return place_token(column, row + 1)
    end
end

