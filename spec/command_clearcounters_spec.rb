require 'rspec'
require 'spec_helper'
require 'RHAProxyAPI/Command/clear_counters'

describe 'HAProxy \'clear counters\' command' do

  it 'should clear all counters' do
    clear_counters_command = RHAProxyAPI::Command::ClearCounters.new(true)
    expect(clear_counters_command.get_socket_command).to eq('clear counters all')
  end

  it 'should clear counters' do
    clear_counters_command = RHAProxyAPI::Command::ClearCounters.new
    expect(clear_counters_command.get_socket_command).to eq('clear counters')
  end

  it 'should not allow injection' do
    clear_countes_command = RHAProxyAPI::Command::ClearCounters.new("; set weight 0")
    expect(clear_countes_command.get_socket_command).to eq('clear counters all')
  end

end