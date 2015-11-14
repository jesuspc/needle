defmodule Needle do
  defmacro __using__(opts) do
    quote do
      import Needle
    end
  end

  defmacro defdependency(name) do
    caller = hd __CALLER__.context_modules
    quote do
      defp unquote(:"#{name}")() do
        unquote(Needle.get_dependency caller, name)
      end
    end
  end

  def init do
    create_table
    :ets.insert :dependencies, { Elixir.Dependency1, %{ d2: Elixir.Dependency2 } }
    :ets.insert :dependencies, { Elixir.Something, %{ d1: Elixir.Dependency1 } }
  end

  def get_dependency(module, name) do
    [{_, storage}] = :ets.lookup :dependencies, module
    storage[name]
  end

  def create_table do
    :ets.new :dependencies, [:set, :protected, :named_table]
  end
end

Needle.init

defmodule Something do
  use Needle
  defdependency :d1

  def bar do
    d1
  end
end

defmodule Dependency1 do
  use Needle
  defdependency :d2

  def bar do
    d2
  end
end

defmodule Dependency2 do
  def val do
    1 
  end
end

