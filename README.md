# Annotate Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for [annotating builds](https://buildkite.com/docs/agent/v3/cli-annotate).

This plugin allows you to add additional information to Buildkite build pages using Markdown. Although annotations created with this plugin are limited to [static Markdown](#body-optional-string), annotations can [embed and link to artifacts](https://buildkite.com/docs/agent/v3/cli-annotate#embedding-and-linking-artifacts-in-annotations).

To upload an artifact and create an annotation that refers to it in the one step, you would normally need to call the [Buildkite Agent CLI](https://buildkite.com/docs/agent/v3#usage) directly. This plugin makes it possible to achieve this declaratively in your `pipeline.yml`. Artifacts can be uploaded using the [`artifact_paths`](https://buildkite.com/docs/pipelines/artifacts#upload-artifacts-with-a-command-step) attribute of a command step or the [Artifacts Buildkite Plugin](https://github.com/buildkite-plugins/artifacts-buildkite-plugin), followed by this plugin to create the annotation.

## Examples

Create an annotation by adding the following to your `pipeline.yml`:

```yml
steps:
  - command: ...
    plugins:
      - iress/annotate#v1.0.0:
          body: "Build complete"
```

You can specify the visual [`style`](#style-optional-string) of an annotation:

```yml
steps:
  - command: ...
    plugins:
      - iress/annotate#v1.0.0:
          body: "Build complete"
          style: info
```

You can [embed and link to artifacts](https://buildkite.com/docs/agent/v3/cli-annotate#embedding-and-linking-artifacts-in-annotations):

```yml
steps:
  - command: ...
    artifact_paths:
      - "coverage/index.html"
    plugins:
      - iress/annotate#v1.0.0:
          body: 'Read the <a href="artifact://coverage/index.html">uploaded coverage report</a>'
```

You can create multiple annotations by specifying a unique [`context`](#context-optional-string):

```yml
steps:
  - command: ...
    plugins:
      - iress/annotate#v1.0.0:
          body: "Awaiting testing..."
          context: junit
```

You can update an existing annotation by providing the same context:

```yml
steps:
  - command: ...
    plugins:
      - iress/annotate#v1.0.0:
          body: "Testing complete!"
          style: success
          context: junit
```

You can [`append`](#append-optional-string) to an existing annotation by providing the same context:

```yml
steps:
  - command: ...
    plugins:
      - iress/annotate#v1.0.0:
          body: "Testing complete!"
          append: true
          context: junit
```

## Configuration

### `body` (optional, string)

The body of the annotation, written in [Markdown syntax](https://buildkite.com/docs/agent/v3/cli-annotate#supported-markdown-syntax).

### `context` (optional, string)

The context of the annotation, used to differentiate this annotation from others.

### `style` (optional, string)

The [style](https://buildkite.com/docs/agent/v3/cli-annotate#annotation-styles) of the annotation (`success`, `info`, `warning` or `error`).

### `append` (optional, boolean)

Append to the body of an existing annotation.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
