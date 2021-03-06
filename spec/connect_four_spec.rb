require_relative '../lib/connect_four'
describe ConnectFour do
    describe '#get_column' do
        subject(:game_column) { described_class.new }

        context 'when user inputs valid input straight away' do
            valid_input = '5'
            before do
                allow(game_column).to receive(:gets).and_return(valid_input)
            end

            it 'returns user input' do
                column = game_column.get_column
                expect(column).to eq(5)
                game_column.get_column
            end
        end
        
        context 'when user inputs valid input after two invalid inputs' do
            calls = 0
            before do
                letter = 'a'
                symbol = '?'
                valid_input = '5'
                allow(game_column).to receive(:gets).and_return(letter, symbol, valid_input)
            end
            
            it 'displays error twice' do
                enter_column_message = "Enter column (0 - 6): "
                error_message = "Invalid column. Please enter integer from 0 to 6"
                expect(game_column).to receive(:puts).with(enter_column_message).exactly(3).times
                expect(game_column).to receive(:puts).with(error_message).twice
                game_column.get_column
            end
        end
    end
    
    describe "#place_token" do
        subject(:game_place_token) { described_class.new }
        
        context 'when column is full' do
            column = 0
            before do
                token = 'X'
                # fill column to top
                for row in (0..5) do
                    game_place_token.grid[row][column] = 'O'
                end
            end

            it 'returns false' do
                valid_move = game_place_token.place_token(column)
                expect(valid_move).to be false
            end
        end
        
        context 'when column is empty' do
            token = 'X'
            column = 0
            bottom_row = 5
            
            it 'places token to bottom row' do
                game_place_token.token = token
                game_place_token.place_token(column)
                bottom_space = game_place_token.grid[bottom_row][column]
                expect(bottom_space).to eql(token)
            end
            
            it 'returns true' do
                valid_move = game_place_token.place_token(column)
                expect(valid_move).to be true
            end
        end
        
        context 'when column is half full' do
            token = 'X'
            column = 0
            lowest_valid_row = 2
            before do
                # fill column half way
                for row in (3..5) do
                    game_place_token.grid[row][column] = 'O'
                end
            end
            
            it 'places token on top of highest token in column' do
                game_place_token.token = token
                game_place_token.place_token(column)
                lowest_valid_space = game_place_token.grid[lowest_valid_row][column]
                expect(lowest_valid_space).to eql(token)
            end
            
            it 'returns true' do
                valid_move = game_place_token.place_token(column)
                expect(valid_move).to be true
            end
        end     
    end

    describe '#game_over?' do
        subject(:game_over) { described_class.new }

        context 'when there is no winner' do
            before do
                for row in (3..5) do
                    game_over.grid[row][0] = 'X'
                end
            end

            it 'returns false' do
                is_game_over = game_over.game_over?
                expect(is_game_over).to be false
            end
        end
        
        context 'when X wins horizontally' do
            before do
                for column in (1..4) do
                    game_over.grid[0][column] = 'X'
                end
                allow(game_over).to receive(:puts)
            end

            it 'returns true' do
                game_over.token = 'X'
                is_game_over = game_over.game_over?
                expect(is_game_over).to be true
            end
        end
        
        context 'when X wins vertically' do
            before do
                for row in (1..4) do
                    game_over.grid[row][0] = 'X'
                end
                allow(game_over).to receive(:puts)
            end

            it 'returns true' do
                game_over.token = 'X'
                is_game_over = game_over.game_over?
                expect(is_game_over).to be true
            end
        end
        
        context 'when X wins diagonally' do
            before do
                for row in (1..4) do
                    for column in (1..4) do
                        game_over.grid[row][column] = 'X' if row == column
                    end
                end
                allow(game_over).to receive(:puts)
            end

            it 'returns true' do
                game_over.token = 'X'
                is_game_over = game_over.game_over?
                expect(is_game_over).to be true
            end
        end
        
        context 'when O wins diagonally' do
            before do
                for row in (1..4) do
                    for column in (1..4) do
                        game_over.grid[row][column] = 'O' if row == column
                    end
                end
                allow(game_over).to receive(:puts)
            end

            it 'returns true' do
                game_over.token = 'O'
                is_game_over = game_over.game_over?
                expect(is_game_over).to be true
            end
        end

    end

    describe '#get_token_paths' do
        subject(:game_paths) { described_class.new }

        context 'when token is at the center of the grid' do
            it 'returns all surrounding tokens' do
                row = 3
                column = 3
                paths = [[2, 2], [3, 2], [3, 4], [2, 3], [4, 3], [2, 4], [4, 2], [4, 4]]
                result_paths = game_paths.get_token_paths(row, column)
                expect(result_paths).to eql(paths)
            end
        end

        context 'when token is at the edge of the grid' do
            it 'returns surrounding tokens without leaving grid' do
                row = 0
                column = 3
                paths = [[0, 2], [0, 4], [1, 3], [1, 2], [1, 4]]
                result_paths = game_paths.get_token_paths(row, column)
                expect(result_paths).to eql(paths)
            end
        end

        context 'when token is in the corner of the grid' do
            it 'returns surrounding tokens without leaving grid' do
                row = 0
                column = 0
                paths = [[0, 1], [1, 0], [1, 1]]
                result_paths = game_paths.get_token_paths(row, column)
                expect(result_paths).to eql(paths)
            end
        end
    end
end