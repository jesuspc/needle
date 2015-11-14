defmodule Needle do
  defmacro __using__(opts) do
    init
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

  def get_dependency(module, name) do
    [{_, storage}] = :ets.lookup :dependencies, module
    storage[name]
  end

  def define_dependencies(module, deps) do
    :ets.insert :dependencies, { module, deps }
  end

  defp init do
    unless table_initialized?, do: create_table && seed
  end

  defp table_initialized? do
    !!Enum.find(:ets.all, &(&1 == :dependencies))
  end

  defp seed do
    define_dependencies Elixir.NeedleTest.Something, %{ d1: Elixir.NeedleTest.Dependency1 }
    define_dependencies Elixir.NeedleTest.Dependency1, %{ d2: Elixir.NeedleTest.Dependency2 }
  end

  defp create_table do
    :ets.new :dependencies, [:set, :protected, :named_table]
  end
end