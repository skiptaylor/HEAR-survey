namespace :assets do
  desc 'Builds and minifies for production (Let the server do this!)'
  task :precompile do
    Dir.glob("./public/**/*{.js,.css}").each do |file|
      case File.extname(file)
      when '.css'
        minifile = Sass::Engine.new(File.read(file), { style: :compressed,
                                                      syntax: :scss }).render()
      when '.js'
        minifile = Uglifier.new.compile(File.read(file)).strip()
      end
      IO.write(file, minifile, mode: 'w')
    end
  end
end
