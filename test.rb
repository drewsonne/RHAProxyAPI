require './lib/RHAProxyAPI.rb'

exec = Executor.new("192.168.59.103:8080", Executor::SOCKET)
stats = Stats.get(exec)

puts stats.dumpServiceTree
