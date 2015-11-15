# Needle

## Installation

Simply add it to your app's dependencies:

```elixir
def deps do
  [{:needle, git: "git@github.com:jesuspc/needle.git"}]
end
```

## Usage

You will need to define a Box module in which the dependencies for each of your
dependant modules will be defined:

```elixir
defmodule Box do
  def deps do
    %{
      Elixir.Foo => %{ logger: Elixir.DefaultLogger },
      Elixir.DefaultLogger => %{ log_level: "debug" }
    }
  end
end
```

This box can be overriden using Needle.set_box. Doing so is a useful technique to
customize your tests without using environment variables.

Dependencies can be injected in each dependant module using Needle's defdependency macro:

```elixir
defmodule Foo do
  use Needle
  defdependency :logger

  def say_hello do
    logger.puts "hello"
  end
end

defmodule DefaultLogger do
  use Needle
  defdependency :log_level

  def puts(message) do
    IO.puts "[#{log_level}] #{message}"
  end
end
```

By default those dependecies are hard-injected on compile time, not dynamically resolved.

## TODO

- Dynamically resolved dependencies.


