namespace :lint do

  desc 'Report failures to follow Ruby coding conventions'
  task :all do
    Rake::Task['lint:no_trailing_whitespace'].invoke
    Rake::Task['lint:newline_eof'].invoke
    Rake::Task['lint:crlf'].invoke
    Rake::Task['lint:spaces_indentation'].invoke
  end

  desc 'Report white space at End Of Lines'
  # https://github.com/bbatsov/ruby-style-guide#no-trailing-whitespace
  task :no_trailing_whitespace do
    each_text_file(directories) do |filename, f|
      f.each_line do |line|
        line.chomp!
        puts "#{filename}:#{f.lineno}:#{expand_tabs(line).sub(/([[:blank:]]+)$/, "\033[41m\\1\033[0m")}\033[34m$\033[0m" if line =~ /[[:blank:]]+$/
      end
    end
  end

  desc 'Report missing LF at EOF'
  # https://github.com/bbatsov/ruby-style-guide#newline-eof
  task :newline_eof do
    each_text_file(directories) do |filename, f|
      if f.read[-1] != "\n" then
        puts "#{filename} does not ends with a new line"
      end
    end
  end

  desc 'Report CR+LF line endings'
  # https://github.com/bbatsov/ruby-style-guide#crlf
  task :crlf do
    each_text_file(directories) do |filename, f|
      if f.read =~ /\r\n/ then
        puts "#{filename} has non-Unix line endings"
      end
    end
  end

  desc 'Report file with tabulations'
  # https://github.com/bbatsov/ruby-style-guide#spaces-indentation
  task :spaces_indentation do
    each_text_file(directories) do |filename, f|
      # XXX Maybe it's better for consistency to ALWAYS use 2 space soft-tabs
      #next if ['.css', '.js'].include? File.extname(filename)
      f.each_line do |line|
        line.chomp!
        puts "#{filename}:#{f.lineno}:#{expand_tabs(line, true)}" if line =~ /\t/
      end
    end
  end

  # http://markmail.org/message/avdjw34ahxi447qk
  def expand_tabs(s, highlight = false, tab_stops = 8)
    replace = if highlight then
               "\033[41m \033[0m"
             else
               ' '
             end
    s.gsub(/([^\t\n]*)\t/) do
      $1 + replace * (tab_stops - ($1.size % tab_stops))
    end
  end

  def directories
    @directories ||= [
      'app',
      'config',
      'db',
      'lib',
      'test',
    ].map { |d| File.join(Rails.root, d, '**', '*') }
  end

  def each_text_file(directories)
    Dir.glob(directories) do |filename|
      next unless File.file?(filename)
      next if filename =~ /\/images\//
      File.open(filename) do |f|
        yield(filename, f)
      end
    end
  end
end
