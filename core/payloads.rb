#!/usr/bin/env ruby

require 'core/colors'

class Payloads
    def initialize
        @cust_init = 1
    end

    def generate_payload(file, data)
        if File.directory? file
            if File.exists? file
                if file[-1] == "/"
                    file = "#{file}payload.cpp"
                    sleep(0.5)
                    puts "#{g}Creating payload..."
                    sleep(1)
                    puts "#{g}Saving to #{file}..."
                    sleep(0.5)
                    open(file, 'w') { |f|
                      f.puts data
                    }
                    puts "#{s}Saved to #{file}!"
                else
                    file = "#{file}/payload.cpp"
                    sleep(0.5)
                    puts "#{g}Creating payload..."
                    sleep(1)
                    puts "#{g}Saving to #{file}..."
                    sleep(0.5)
                    open(file, 'w') { |f|
                        f.puts data
                    }
                    puts "#{s}Saved to #{file}!"
                end
            else
                puts "#{e}Output directory: #{file}: does not exist!"
                abort()
            end
        else
            direct = File.dirname(file)
            if direct == ""
                direct = "."
            else
                nil
            end
            if File.exists? direct
                if File.directory? direct
                    sleep(0.5)
                    puts "#{g}Creating payload..."
                    sleep(1)
                    puts "#{g}Saving to #{file}..."
                    sleep(0.5)
                    open(file, 'w') { |f|
                        f.puts data
                    }
                    puts "#{s}Saved to #{file}!"
                else
                    puts "#{e}Error: #{direct}: not a directory!"
                    abort()
                end
            else
                puts "#{e}Output directory: #{direct}: does not exist!"
                abort()
            end
        end
    end
end
