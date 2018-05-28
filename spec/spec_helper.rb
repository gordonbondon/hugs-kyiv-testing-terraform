require 'yaml'
require 'json'
require 'rspec'
require 'open3'

RSpec.configure do |config|
  config.fail_fast = true
end

# helper functions
# get terraform plan
def terraform_plan(folder:, variables: {}, varfile: nil)
  init_command = "terraform init #{folder}"
  # puts "Running init command: '#{init_command}'"
  _, i_e, i_s = Open3.capture3(init_command)
  raise("Terraform init has failed with error #{i_e}") unless i_s.exitstatus == 0

  plan_command = ['terraform', 'plan']

  variables.each do |name, value|
    plan_command << "-var '#{name}=#{value}'"
  end

  plan_command << "-var-file=#{varfile}" if varfile

  plan_command << folder if folder

  # puts "Running plan command: '#{plan_command.join(' ')}'"
  raw, r_e, r_s = Open3.capture3(plan_command.join(' '))
  raise("Terraform plan has failed with error: #{r_e}") unless r_s.exitstatus == 0

  capture_command = 'parse-terraform-plan'
  # puts "Running parse command: '#{capture_command}'"
  plan, p_e, p_s = Open3.capture3(capture_command, :stdin_data => raw)
  raise("Parsing plan failed with error: #{p_e}") unless p_s.exitstatus == 0

  JSON.parse(plan)
end

# get resource by type
def get_resources(plan, resourc_type)
  plan['changedResources'].select{|resource| resource['type'] == resourc_type}
end

# get resource attributes
def get_attributes(resource)
  parsed_attr = {}

  resource['changedAttributes'].each do |attr, spec|
    parsed_attr[attr] = spec['new']['value']
  end

  parsed_attr
end
