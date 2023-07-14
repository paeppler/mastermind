class Game
    @@code_arr = []
    @@guess_arr = []
    @@completely_right_guess = 0
    @@rounds_played = 1

    def initialize
        generate_code 
    end

    def generate_code
        4.times do
            @@code_arr.push(rand(1..6))
        end
    end

    def guess
        puts"round #{@@rounds_played}. Enter 4-digit code with numbers 1-6"
        @@guess_arr = gets.chomp.to_s.split('').map(&:to_i)

        while @@guess_arr.any? {|element| !(1..6).cover?(element) } || @@guess_arr.length != 4 do
            puts 'invalid input. Try again'
            @@guess_arr = gets.chomp.to_s.split('').map(&:to_i)
        end
        p @@guess_arr
        @@rounds_played += 1
    end


    def check_answer(guess, code)
        @@completely_right_guess = 0
        half_right_guess = 0

        4.times do |i|
            if guess[i] == code[i]
                @@completely_right_guess += 1
                code[i] = 0
                guess[i] = 7
            end
        end

        guess.each do |element|
            if code.include?(element)
                half_right_guess += 1
                code.delete(element)
            end
        end

        puts "#{@@completely_right_guess} digits in the right place!"
        puts "#{half_right_guess} digits in code, but in the wrong place!"
        puts ""
    end

    def play_game
        while true 
            if @@rounds_played < 9
                self.guess
                code_copy = @@code_arr.dup
                self.check_answer(@@guess_arr, code_copy)
                if @@completely_right_guess == 4
                    puts "You won!"
                    break
                end
            else 
                puts "no more rounds. better luck next time!"
                puts "the answer was #{@@code_arr}"
                break
            end
        end        
    end
end

newgame = Game.new
newgame.play_game
