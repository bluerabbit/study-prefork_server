require 'socket'

socket = TCPServer.open('0.0.0.0', 8080)

[:INT, :QUIT].each do |signal|
  Signal.trap(signal) do
    wpids.each { |wpid| Process.kill(signal, wpid) }
  end
end

wpids = []

5.times do
  wpids << fork do
    loop do
      connection = socket.accept
      puts 1
      connection.puts 'Hello'
      connection.close
    end
  end
end

require 'pp'
pp wpids

Process.waitall
