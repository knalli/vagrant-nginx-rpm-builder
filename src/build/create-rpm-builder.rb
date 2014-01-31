require 'erb'

def loadProperties
  begin
    require 'yaml'
    YAML.load(File.open('./../../build.yaml'))
  rescue
    {
        'dependencies' => {
            'nginx_rpm_stable' => true,
            'nginx_rpm_version' => '1.4.2',
            'nginx_rpm_release' => '1',
            'openssl_version' => '1.0.1e'
        }
    }
  end
end

props = loadProperties()
template = ERB.new File.open('./templates/build.sh.erb').read
puts template.result()