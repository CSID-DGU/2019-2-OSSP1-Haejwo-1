class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def generate_controller
    template "service.rb", "app/services/#{name}.rb"
    template "test.rb", "test/services/#{name}_test.rb"
  end

  private

  def service_name
    "#{name.classify}"
  end
end
