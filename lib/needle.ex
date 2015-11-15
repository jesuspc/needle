defmodule Needle do
  defmacro __using__(_opts) do
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
    box.deps[module][name]
  end

  def set_box(value) do
    unless table_initialized?, do: create_table && :ets.insert(:dependencies, {:box, value})
  end

  def box do
    case get_box do
      [{:box, box}] -> box
      _ -> Box
    end
  end

  defp get_box do
    unless table_initialized?, do: create_table
    :ets.lookup :dependencies, :box
  end

  defp table_initialized? do
    !!Enum.find(:ets.all, &(&1 == :dependencies))
  end

  defp create_table do
    :ets.new :dependencies, [:set, :protected, :named_table]
  end
end