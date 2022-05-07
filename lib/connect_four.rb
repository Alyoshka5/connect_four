class ConnectFour
    attr_accessor :grid, :token
    def initialize
        @grid = [[' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ']]
        @token = 'O'
    end

    def play_game
        until game_over?() do
            @token = @token == 'X' ? 'O' : 'X'
            display_grid()
            puts "#{@token}'s turn:"
            loop do
                column = get_column()
                break if place_token(column)
            end
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

    def game_over?
        for row in (0..5) do
            for column in (0..6) do
                if @grid[row][column] == @token && winner?(row, column)
                    display_grid()
                    puts "#{token} Won!"
                    return true
                end
            end
        end
        false
    end

    def winner?(row, column, direction = nil)  # tested in game_over? method
        if direction.nil?
            paths = get_token_paths(row, column)
            paths.each do |path|
                path_row = path[0]
                path_col = path[1]
                path_direction = get_path_direction(row, column, path_row, path_col)
                if @grid[path_row][path_col] == @token && winner?(path_row, path_col, path_direction) >= 2
                    return true
                end
            end
            return false
        else
            child_row = row+direction[0]
            child_col = column+direction[1]
            return 0 if child_row > 5 || child_row < 0 || child_col > 6 || child_col < 0
            if @grid[child_row][child_col] == @token
                return winner?(child_row, child_col, direction) + 1
            else
                return 0
            end
        end
    end

    def get_token_paths(row, column)
        paths = []
        directions = [[-1, -1], [0, -1], [0, 1], [-1, 0], [1, 0], [-1, 1], [1, -1], [1, 1]]
        directions.each do |direction|
            new_row = row + direction[0]
            new_col = column + direction[1]
            if new_row <= 5 && new_row >= 0 && new_col <= 6 && new_col >= 0
                paths << [new_row, new_col]
            end
        end
        paths
    end

    def get_path_direction(row, column, path_row, path_col)
        [path_row - row, path_col - column]
    end
end
