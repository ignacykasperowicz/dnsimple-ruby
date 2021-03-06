require 'spec_helper'

describe DNSimple::Client do

  let(:klass) { described_class }

  before :each do
    @_username  = DNSimple::Client.username
    @_password  = DNSimple::Client.password
    @_api_token = DNSimple::Client.api_token
    @_host      = DNSimple::Client.host
  end

  after do
    DNSimple::Client.username   = @_username
    DNSimple::Client.password   = @_password
    DNSimple::Client.api_token  = @_api_token
    DNSimple::Client.host       = @_host
  end

  [:get, :post, :put, :delete].each do |method|
    describe ".#{method}" do
      let(:response) { stub('response', :code => 200) }

      it "uses HTTP authentication if there's a password provided" do
        DNSimple::Client.username  = 'user'
        DNSimple::Client.password  = 'pass'
        DNSimple::Client.api_token = nil

        HTTParty.expects(method).
          with('https://test.dnsimple.com/domains',
            :format => :json, :headers => {'Accept' => 'application/json'},
            :basic_auth => {:username => 'user', :password => 'pass'}).
          returns(response)

        DNSimple::Client.send(method, 'domains')
      end

      it "uses header authentication if there's an api token provided" do
        DNSimple::Client.username  = 'user'
        DNSimple::Client.password  = nil
        DNSimple::Client.api_token = 'token'

        HTTParty.expects(method).
          with('https://test.dnsimple.com/domains',
            :format => :json, :headers => {'Accept' => 'application/json',
            'X-DNSimple-Token' => 'user:token'}).
          returns(response)

        DNSimple::Client.send(method, 'domains')
      end

      it "raises an error if there's no password or api token provided" do
        DNSimple::Client.username  = 'user'
        DNSimple::Client.password  = nil
        DNSimple::Client.api_token = nil

        lambda {
          DNSimple::Client.send(method, 'domains')
        }.should raise_error(DNSimple::Error, 'A password or API token is required for all API requests.')
      end
    end
  end


  describe ".base_uri" do
    it "returns the qualified API uri" do
      klass.host = "api.dnsimple.com"
      klass.base_uri = "https://api.dnsimple.com/"
    end
  end

  describe ".base_uri=" do
    it "sets the host" do
      klass.base_uri = "http://api1.dnsimple.com/"
      klass.host.should == "api1.dnsimple.com"
      klass.base_uri = "http://api2.dnsimple.com"
      klass.host.should == "api2.dnsimple.com"
    end
  end

end
