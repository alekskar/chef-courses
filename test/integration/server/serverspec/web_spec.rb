require 'serverspec'
require 'net/http'

set :backend, :exec

describe "nginx is installed" do

  it "nginx" do
    expect(package('nginx')).to be_installed
  end
end

describe "services is running" do

  it "nginx running and enabled services" do
    expect(service("nginx")).to be_enabled
    expect(service("nginx")).to be_running
  end

  it "is nginx listening port" do
    expect(port(80)).to be_listening
    expect(port(22)).to be_listening
  
  end

  it "is jenkins listening port" do
    expect(port(8080)).to be_listening
  end
  
  it 'responce' do
     url = URI("http://localhost")
     r = Net::HTTP.get_response(url)
     expect(r.is_a?(Net::HTTPOK))
  end

end
