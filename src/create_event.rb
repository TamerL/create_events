require 'pry'
require './src/speaker'
require './src/event'
require './src/talk'
require './src/time'

@events = []
@speakers = []
@talks = []
puts "Hi, Welcome to Mad Events application."
# sleep(2)
puts "For commands examples please enter 'EXAMPLES'."
puts "To exit please enter 'EXIT'."
puts "Please enter your command:\n\n"

while true do
  input = gets.chomp()
  # removing ` from the commands
  input.gsub!(/[`]/, '')
  if !input.match(/[A-Z]||[a-z]/)
    puts "Wrong command, please try again.\n\n"
    next
  end
  command_words = input.split(" ")
  # checking the first word in the command
  case command_words[0]
  when "EXAMPLES", "examples"
    puts "Here are some examples of what commands you can run:"
    puts "- CREATE EVENT event_name"
    puts "- CREATE SPEAKER speaker_name"
    puts "- CREATE TALK event_name talk_name talk_start_time talk_end_time speaker_name"
    puts "- PRINT TALKS event_name => output the talks for an event sorted by the start time"
    next
  # type EXIT to quit
  when "EXIT", "exit"
    break
  # if Print then check the next word
  when "PRINT", "print"
    if command_words[1] == "TALKS"
      @event = @events.select { |ev|
                 ev.name == command_words[2]
               } [0] unless command_words[2] == nil
      @event ? @event.sorted_print : (puts "The event doesn't exist.")
    end
    # if check first word is CREATE, check if EVENT is the next word
  when "CREATE", "create"
    case command_words[1]
    when "EVENT", "event"
      @events.push(Event.new(command_words[2]))
      puts "The event '#{command_words[2]}' is successfully created."
    when "SPEAKER", "speaker"
      @speakers.push(Speaker.new(command_words[2]))
      puts "The speaker '#{command_words[2]}' is successfully created."
    when "TALK", "talk"
      if input[/'(.*?)'/m, 1]
        # extract the talk name
        talk_name = input[/'(.*?)'/m, 1]
        # finding the talk name index
        indeces_talk_name = command_words.each_index.select { |i|
          command_words[i] =~ /'/m
        } .reverse
        # Deleting the ` and inserting the talk name back in the command.
        indeces_talk_name.each { |i|
          command_words.delete_at(i)
        }
        command_words.insert(indeces_talk_name.last, talk_name)
      end
      begin
        # check if the time is formatted as 9:00am
        Time.is_formatted?(command_words[4])
        Time.is_formatted?(command_words[5])
      rescue => e
        puts e.message
        next
      end
      if Time.to_minutes(command_words[4]) > Time.to_minutes(command_words[5])
        puts "start_time should be before end_time."
        next
      end
      @speaker = @speakers.select { |sp| sp.name == command_words[6] }[0]
      @event = @events.select { |ev| ev.name == command_words[2] }[0]
      if @event
        if @speaker
          @talks.push(Talk.new(event: @event, name: command_words[3],
                               start_time: command_words[4], end_time: command_words[5],
                               speaker: @speaker))
          begin
            @event.book_talk(talk: @talks.last)
          rescue => e
            puts e.message
            next
          end
          puts "The talk '#{command_words[3]}' is successfully created."
        else
          puts "Speaker #{command_words[6]} should be created first."
        end
      else
        puts "Event #{command_words[2]} should be created first."
      end
    else
      puts "Wrong command, please try again\n\n"
      next
      end
  else
    puts "Wrong command, please try again.\n\n"
    next
  end
end
