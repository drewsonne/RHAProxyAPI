require 'rspec'
require 'spec_helper'
require 'RHAProxyAPI/Command/enable_server'

describe 'HAProxy \'enable server\' command' do

  it 'should enable server counters' do
    clear_counters_command = RHAProxyAPI::Command::EnableServer.new('backend1', 'server1')
    expect(clear_counters_command.get_socket_command).to eq('enable server backend1/server1')
  end

  it 'should not allow injection' do

    expect { RHAProxyAPI::Command::EnableServer.new('backend1;', 'server1') }.to raise_error(SecurityError)
    expect { RHAProxyAPI::Command::EnableServer.new('backend1', 'server1;') }.to raise_error(SecurityError)
    expect { RHAProxyAPI::Command::EnableServer.new('backend1;', 'server1;') }.to raise_error(SecurityError)

  end

  it 'should escape spaces and slashes in backend/server' do

    backend_space = RHAProxyAPI::Command::EnableServer.new('back end1', 'server1')
    server_space  = RHAProxyAPI::Command::EnableServer.new('backend1', 'server 1')
    both_space = RHAProxyAPI::Command::EnableServer.new('back end1', 'server 1')

    expect(backend_space.get_socket_command).to eq('enable server back\ end1/server1')
    expect(server_space.get_socket_command).to eq('enable server backend1/server\ 1')
    expect(both_space.get_socket_command).to eq('enable server back\ end1/server\ 1')

    backend_slash = RHAProxyAPI::Command::EnableServer.new('back/end1', 'server1')
    server_slash = RHAProxyAPI::Command::EnableServer.new('backend1', 'server/1')
    both_slash = RHAProxyAPI::Command::EnableServer.new('back/end1', 'server/1')

    expect(backend_slash.get_socket_command).to eq('enable server back\/end1/server1')
    expect(server_slash.get_socket_command).to eq('enable server backend1/server\/1')
    expect(both_slash.get_socket_command).to eq('enable server back\/end1/server\/1')

  end

end