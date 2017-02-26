white_on_red = "\e[37m\e[41m%s\e[0m"
prefix = white_on_red % "TMJ[crawlers]"

IRB.conf[:PROMPT][:TMJ] = {
  :PROMPT_I => "#{prefix} (%m):%03n:%i> ",  # Normal Prompt
  :PROMPT_N => "#{prefix} (%m):%03n:%i> ",  # Multiline definition
  :PROMPT_S => "#{prefix} (%m):%03n:%i%l ", # Multiline string
  :PROMPT_C => "#{prefix} (%m):%03n:%i* ",  # Multiline expression
  :RETURN   => "=> %s\n"            # Return
}
IRB.conf[:PROMPT_MODE] = :TMJ

# Load up normal irbrc file if one exists
ENV["IRBRC"] = ENV["IRBRC_WAS"]
IRB.conf[:RC_NAME_GENERATOR] = nil
begin
  load IRB.rc_file
rescue LoadError, Errno::ENOENT
end
