environment_variables = ["BITRISE_GIT_BRANCH", "BITRISE_GIT_TAG", "BITRISE_GIT_COMMIT", "BITRISEIO_GIT_BRANCH_DEST", "BITRISE_GIT_MESSAGE"]

if ARGV.length < 1
  puts "Please specify a number of repeated workflows in the pipeline"
  exit
end

def prepare_metadata
    return "  - opts:\n      is_expand: false\n    "
end

def retrieve_environment_variable (variable_name)
    return ENV.fetch(variable_name) { "''" }
end

def create_environment_variable_pair (variable_name)
    return "#{variable_name}: #{retrieve_environment_variable(variable_name)}"
end

def prepare_environment_configuration (variable_name)
   return prepare_metadata() + create_environment_variable_pair(variable_name) + "\n"
end

def print_environment_variables (names)
    names.each do |x|
        if ENV.include?(x)
            puts prepare_environment_configuration(x)
        end
    end
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
print_environment_variables(environment_variables)
