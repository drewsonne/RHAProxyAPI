require 'rspec'
require 'spec_helper'
require 'RHAProxyAPI/command'

describe 'Get Commands' do

  it 'should not have socket implemented' do
    command = RHAProxyAPI::Command::Base.new
    expect {
      command.get_socket_command
    }.to raise_error(ArgumentError)  # This actually raises NotImplementedError. How to test this properly?
  end

  it 'should not have socket implemented' do
    command = RHAProxyAPI::Command::Base.new
    expect {
      command.get_http_command
    }.to raise_error(ArgumentError)  # This actually raises NotImplementedError. How to test this properly?
  end

end