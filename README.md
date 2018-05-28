# Examples for #2 Kyiv HashiCorp User Group meetup

This repo contains some examples for my [presentation](https://docs.google.com/presentation/d/1CEKySxgpLP0Y5YRkxxGwIfCI9SlzFq70-TycDw6tG4Y/edit?usp=drivesdk) on testing terraform modules.

## Prerequisites

Install ruby dependencies:
```
bundle install
```

Install [terraform-plan-parser](https://github.com/lifeomic/terraform-plan-parser):
```
npm install -g terraform-plan-parser
```

AWS credentials should be configured [link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#config-settings-and-precedence)

## Unit tests

Unit tests are based on [terraform-plan-parser](https://github.com/lifeomic/terraform-plan-parser) and parsing functions
in [./spec/spec_helper.rb](./spec/spec_helper.rb). Test specs are located in [./spec/unit/module_spec.rb](./spec/unit/module_spec.rb)

Run unit tests:
```
rspec --format documentation
```

## Integration tests

Integration test use [test-kitchen] with [kitchen-terraform] plugin and [awspec] with [kitchen-verifier-awspec] plugin.
Test specs are in [./test/integration/default/instance.rb](./test/integration/default/instance.rb)

Run integration tests:
```
bundle exec kitchen test
```

## Links
- https://www.contino.io/insights/top-3-terraform-testing-strategies-for-ultra-reliable-infrastructure-as-code
