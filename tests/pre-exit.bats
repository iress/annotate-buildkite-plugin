#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment the following line to debug stub failures
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Creates an annotation" {
  export BUILDKITE_PLUGIN_ANNOTATE_BODY="Build complete"

  stub buildkite-agent 'annotate "Build complete" : echo Annotation created'

  run "$PWD/hooks/pre-exit"

  assert_success
  assert_output --partial "Annotation created"

  unstub buildkite-agent
}

@test "Creates an annotation with a style" {
  export BUILDKITE_PLUGIN_ANNOTATE_BODY="Build complete"
  export BUILDKITE_PLUGIN_ANNOTATE_STYLE="info"

  stub buildkite-agent 'annotate "Build complete" --style "info" : echo Annotation created'

  run "$PWD/hooks/pre-exit"

  assert_success
  assert_output --partial "Annotation created"

  unstub buildkite-agent
}

@test "Appends to the body of an existing annotation" {
  export BUILDKITE_PLUGIN_ANNOTATE_BODY="Read the uploaded coverage report"
  export BUILDKITE_PLUGIN_ANNOTATE_CONTEXT="junit"
  export BUILDKITE_PLUGIN_ANNOTATE_APPEND="true"

  stub buildkite-agent 'annotate "Read the uploaded coverage report" --context "junit" --append : echo Annotation updated'

  run "$PWD/hooks/pre-exit"

  assert_success
  assert_output --partial "Annotation updated"

  unstub buildkite-agent
}

@test "Updates the style of an existing annotation" {
  export BUILDKITE_PLUGIN_ANNOTATE_STYLE="success"
  export BUILDKITE_PLUGIN_ANNOTATE_CONTEXT="junit"

  stub buildkite-agent 'annotate --context "junit" --style "success" : echo Annotation updated'

  run "$PWD/hooks/pre-exit"

  assert_success
  assert_output --partial "Annotation updated"

  unstub buildkite-agent
}
