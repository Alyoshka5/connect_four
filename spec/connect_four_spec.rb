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
end