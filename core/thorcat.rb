#!/usr/bin/env ruby

require 'optparse'

class ThorCat
    def initialize
        require 'ostruct'
        require 'socket'
        require 'open3'
    end

    def listener(port=31337, hostaddress=nil, ip=nil)
        i = "\033[1;77m[i] \033[0m"
        e = "\033[1;31m[-] \033[0m"
        p = "\033[1;77m[>] \033[0m"
        g = "\033[1;34m[*] \033[0m"
        s = "\033[1;32m[+] \033[0m"
        h = "\033[1;77m[@] \033[0m"
        r = "\033[1;77m[#] \033[0m"
        puts "#{g}Binding to #{hostaddress}:#{port}..."
        sr = system("ping -c 1 #{hostaddress} >/dev/null 2>&1")
        if sr != true
            puts "#{e}Failed to bind to #{hostaddress}:#{port}!"
            abort()
        end
        if ip.nil?
            begin
                server = TCPServer.new(port)
                server.listen(1)
            rescue
                puts "#{e}Failed to bind to #{hostaddress}:#{port}!"
                abort()
            end
            puts "#{g}Listening on port #{port}..."
            @socket = server.accept
        else
                @socket = TCPSocket.open(ip, port)
        end
        if not @socket.peeraddr[2][7..-1]
            address = "127.0.0.1"
        else
            address = @socket.peeraddr[2][7..-1]
        end
        puts "#{g}Connecting to #{address}..."
        sleep(0.5)
        puts "#{g}Sending payload to #{address}..."
        sleep(0.5)
        puts "#{g}Opening #{address} shell..."
        sleep(1)
        while (true)
          if (IO.select([],[],[@socket, STDIN],0))
              socket.close
              return
          end
          begin
              while ((data = @socket.recv_nonblock(100)) != "")
                  STDOUT.write(data);
              end
              break
          rescue Errno::EAGAIN
          end
          begin
              while ((data = STDIN.read_nonblock(100)) != "")
                  @socket.write(data);
              end
              break
          rescue Errno::EAGAIN
          rescue EOFError
              break
          end
          IO.select([@socket, STDIN], [@socket, STDIN], [@socket, STDIN])
        end
    end
end

options = {}
optparse = OptionParser.new do |opts| 
    opts.banner = "Usage: thorcat.rb [-h] [-l <local_host> -p <local_port>]"
    opts.separator ""
    opts.separator "Options: "
    opts.on('-l', '--listen <local_host>', "Start ThorCat listener.") do |mode|
        options[:mode] = mode
        options[:method] = 0
    end
    opts.on('-p', '--port <local_port>', "Local port.") do |port|
        options[:port] = port.to_i
    end
    opts.on('-h', '--help', "Show options.") do 
        puts "Usage: thorcat.rb [-h] [-l <local_host> -p <local_port>]"
        puts ""
        puts "  -h, --help  Show options."
        puts "  -l, --listen <local_host> -p, --port <local_port>  Start ThorCat listener."
        abort()
    end
end
begin
    foo = ARGV[0] || ARGV[0] = "-h"
    optparse.parse!
    mandatory = [:method,:port]
    missing = mandatory.select{ |param| options[param].nil? }
    if not missing.empty?
        puts "Usage: thorcat.rb [-h] [-l <local_host> -p <local_port>]"
        puts ""
        puts "  -h, --help  Show options."
        puts "  -l, --listen <local_host> -p, --port <local_port>  Start ThorCat listener."
        abort()
    end
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
    puts "Usage: thorcat.rb [-h] [-l <local_host> -p <local_port>]"
    puts ""
    puts "  -h, --help  Show options."
    puts "  -l, --listen <local_host> -p, --port <local_port>  Start ThorCat listener."
    abort()  
end

rc = ThorCat.new
case options[:method].to_i
when 0
    rc.listener(options[:port].to_i, options[:mode])
end
