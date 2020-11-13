#!/usr/bin/env ruby

i = "\033[1;77m[i] \033[0m"
e = "\033[1;31m[-] \033[0m"
p = "\033[1;77m[>] \033[0m"
g = "\033[1;34m[*] \033[0m"
s = "\033[1;32m[+] \033[0m"
h = "\033[1;77m[@] \033[0m"
r = "\033[1;77m[#] \033[0m"

class Payloads
    def initialize
        @cust_init = 1
    end

    def generate_payload(file, data)
        w = ENV['OLDPWD']
        Dir.chdir(w)
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
        g = ENV['HOME']
        Dir.chdir(g + "/thoron")
    end
end
