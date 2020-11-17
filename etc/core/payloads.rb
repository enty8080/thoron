#!/usr/bin/env ruby

#
# MIT License
#
# Copyright (c) 2020 EntySec
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

class Payloads
    def generate_payload(file, data, extension)
        i = "\033[1;77m[i] \033[0m"
        e = "\033[1;31m[-] \033[0m"
        p = "\033[1;77m[>] \033[0m"
        g = "\033[1;34m[*] \033[0m"
        s = "\033[1;32m[+] \033[0m"
        h = "\033[1;77m[@] \033[0m"
        r = "\033[1;77m[#] \033[0m"
        w = ENV['OLDPWD']
        Dir.chdir(w)
        if File.directory? file
            if File.exists? file
                if file[-1] == "/"
                    file = "#{file}payload.#{extension}"
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
                    file = "#{file}/payload.#{extension}"
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
