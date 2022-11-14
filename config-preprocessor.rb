if ARGV.length < 1
  puts "Please specify a number of repeated workflows in the pipeline"
  exit
end

num_workflows = ARGV[0].to_i
# puts "Generating a configuration with #{num_workflows} workflow" + ((num_workflows > 1) ? "s" : "")

File.readlines('bitrise.yml').each do |line|
  if line == "    - primary: {}\n"
    puts(line * num_workflows)
  else
    puts(line)
  end
end
