require 'rspec'
require 'spec_helper'
require 'RHAProxyAPI/Command/enable_server'

describe 'HAProxy \'enable server\' command' do

  it 'should enable server counters' do
    clear_counters_command = RHAProxyAPI::Command::EnableServer.new('backend1', 'server1')
    expect(clear_counters_command.get_socket_command).to eq('enable server backend1/server1')
  end

end