ExUnit.start()

defmodule TestBox do
  def deps do
    %{
      Elixir.NeedleTest.Something => %{ d1: Elixir.NeedleTest.Dependency1 },
      Elixir.NeedleTest.Dependency1 => %{ d2: Elixir.NeedleTest.Dependency2 }
    }
  end
end

Needle.set_box TestBox

