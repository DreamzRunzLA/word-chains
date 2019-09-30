class WordChainer

    attr_reader :dictionary

    def initialize(dictionary_file_name="dictionary.txt")
        words = File.readlines(dictionary_file_name).map(&:chomp)
        #set.include? method is much faster than that of an array
        @dictionary = Set.new(words)
    end

    def adjacent_word(word)
        #We want to give it a word and return any word that is adjacent based on any
        #letter being changed out for another while still being in dict
        list_words = []
        alphabet = ("a".."z").to_a
        word.each_char.with_index do |char, index|
            alphabet.each do |letter|
                word[index] = letter
                new_word = word[0...index] + word[index] + word[index+1..-1]
                if @dictionary.include?(new_word)
                    list_words << new_word
                end
            end
        end
        return list_words
    end

    def run(source)
        current_words = [source]
        all_seen_words = [source]

        until current_words.length == 0
            new_current_words = []

            current_words.each do |ele|

                adjacent_word(ele).each do |ele2|
                    if all_seen_words.include?(ele2) == false
                        new_current_words << ele2
                        all_seen_words << ele2
                    else
                        next
                    end
                end
                
            end

            puts new_current_words
            current_words = new_current_words
        end

        return all_seen_words
    end

end