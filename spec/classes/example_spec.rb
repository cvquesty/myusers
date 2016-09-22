require 'spec_helper'

describe 'myusers' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "myusers class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('myusers::params') }
          it { is_expected.to contain_class('myusers::install').that_comes_before('myusers::config') }
          it { is_expected.to contain_class('myusers::config') }
          it { is_expected.to contain_class('myusers::service').that_subscribes_to('myusers::config') }

          it { is_expected.to contain_service('myusers') }
          it { is_expected.to contain_package('myusers').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'myusers class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('myusers') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
