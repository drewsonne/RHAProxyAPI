require 'rspec'
require 'RHAProxyAPI/executor'
require 'spec_helper'
require 'rspec/mocks'

describe 'Socket dispatch' do

  it 'should pass parameters to TCPSocket' do

    allow(Socket).to receive(:tcp) { |host, port, &block|
      expect(host).to eq("127.0.0.1")
      expect(port).to eq(8080)
    }

    RHAProxyAPI::Executor.new("tcp://127.0.0.1:8080", RHAProxyAPI::Executor::SOCKET).open_socket {}
  end

  it 'should pass parameters to UNIXSocket' do

    class MockUnixSocketFile
      def socket?; true end
    end

    # We don't need to create files
    allow(File).to receive(:new) {
      MockUnixSocketFile.new
    }
    allow(Socket).to receive(:unix) { |path|
      expect(path).to eq("/hallo_world")
    }

    RHAProxyAPI::Executor.new("/hallo_world", RHAProxyAPI::Executor::SOCKET).open_socket {}

  end

end