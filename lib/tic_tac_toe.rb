require 'pry'
class TicTacToe

    WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(number)
        number.to_i - 1
    end

    def move(position, player)
        @board[position] = player
    end

    def position_taken?(position)
        @board[position] != " "
    end

    def valid_move?(position)
        if position.between?(0,8)
            !position_taken?(position)
        end
    end

    def turn_count
        @board.select { |position| position != " "}.length
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    def turn
        flip = true

        while flip
            choice = gets.strip
            if valid_move?(choice.to_i - 1)
                
                position = input_to_index(choice)
                player = current_player
                move(position, player)
                flip = false
            end
            display_board
        end
    end

    def threeway_comparison(first, second, third)
        @board[first] == @board[second] && @board[first] == @board[third]
    end

    def won?
        combo = WIN_COMBINATIONS.find { |combination| position_taken?(combination[0]) && threeway_comparison(combination[0], combination[1], combination[2])}
        combo
    end

    def full?
        turn_count == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        win = won?
        !win ? nil : @board[win[0]]
    end

    def play
        while !over?
            turn
        end
        player = winner
        if player
            puts "Congratulations #{player}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end