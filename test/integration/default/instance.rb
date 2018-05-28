require 'awspec'
require 'json'

vars = eval(ENV['KITCHEN_KITCHEN_TERRAFORM_OUTPUT'])

instance_id = vars[:instance_id][:value]

describe ec2(instance_id) do
  it { should have_tag('CostCenter').value('OPS') }
end
