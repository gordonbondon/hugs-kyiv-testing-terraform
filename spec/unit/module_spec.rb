require 'spec_helper'

describe 'app stack module' do
  context 'with type set ot asg' do
    let (:plan) { terraform_plan(
      folder: './test/fixtures/',
      variables: {'type' => 'asg'}) }

    it 'create exactly one aws_launch_template' do
      expect(get_resources(
        plan, 'aws_launch_template').count).to be == 1
    end

    it 'create no instances' do
      expect(get_resources(
        plan, 'aws_instance').count).to be == 0
    end
  end

  context 'with default type' do
    let (:plan) { terraform_plan(folder: './test/fixtures/') }

    it 'create no aws_launch_templates' do
      expect(get_resources(
        plan, 'aws_launch_template').count).to be == 0
    end

    it 'create exactly one aws_instance' do
      expect(get_resources(
        plan, 'aws_instance').count).to be == 1
    end
  end
end
