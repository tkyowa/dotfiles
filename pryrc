Pry.config.auto_indent = true
Pry.config.color = true
# Pry.config.commands.import Pry::ExtendedCommands::Experimental
Pry.config.editor = lambda{ |file, line| "vim #{file} +#{line}" }
Pry.config.history.should_save = true
Pry.config.pager = true

# see: https://github.com/lucapette/dotfiles/blob/master/pryrc
# Disable for pry-remote
# Pry.config.hooks.add_hook :after_session, :say_bye do
  # puts "bye-bye" if Pry.active_sessions == 1
# end

#
# Promptを変更すると複数行の表示がうまくできなくなったりして不便なのでいったんコメントアウト
#
# prompt_proc = lambda do |obj, nest_level, _|
  # ruby_info = ""
  # ruby_info << "#{Rails.version}@" if defined?(Rails)
  # ruby_info << RUBY_VERSION
  # ruby_info = "\e[32m#{ruby_info}\e[0m"
  # nest_info = "#{nest_level}"
  # obj_info  = "\e[33m#{obj}\e[0m"
  # "[#{ruby_info}] #{nest_info}:(#{obj_info}) > "
# end
# Pry.prompt = [prompt_proc, prompt_proc]

Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end
