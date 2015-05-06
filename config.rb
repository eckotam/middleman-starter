# Directory Setup
set :css_dir, 'assets/css'
set :sass_dir, 'assets/css'
set :js_dir, 'assets/js'
set :images_dir, 'assets/img'
set :fonts_dir, 'assets/fonts'
set :partials_dir, 'partials'
set :sass, {
	sourcemap: false
}

# Configure relative links
set :relative_links, true

# Set HAML as template language
set :haml, { :ugly => true, :format => :html5 }

# Bower Configuration
after_configuration do
	sprockets.append_path File.join root, "bower_compoents"
end

# Import packages from bower
sprockets.import_asset 'foundation'
sprockets.import_asset 'bourbon'

# Development-specific configuration
configure :development do
	# Debug assets to true when in development
	set :debug_assets, true

	# Pretty URLs
	activate :directory_indexes

	# Reload the browser automatically whenever files change
	activate :livereload
end

# Build-specific configuration
configure :build do
	# For example, change the Compass output style for deployment
	activate :minify_css

	# Minify Javascript on build
	activate :minify_javascript

	# Enable cache buster
	# activate :asset_hash

	# Use relative URLs
	activate :relative_assets

	# Pretty URLs
	activate :directory_indexes

	after_build do
		system('htmlbeautifier build/*.html --tab-stops 4')
	end
end

activate :deploy do |deploy|
	deploy.method   = :ftp
	deploy.host     = 'FTP_HOST'
	deploy.path     = '/public_html/PROJECT_NAME'
	# Optional Settings
	deploy.user     = '' # no default
	deploy.password = '' # no default
	deploy.build_before = true # default: false
end