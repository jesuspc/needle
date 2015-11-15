ExUnit.start()

defmodule TestBox do
  def deps do
    %{
      Elixir.NeedleTest.Something => %{ dep_1: Elixir.NeedleTest.Dependency1 },
      Elixir.NeedleTest.Dependency1 => %{ dep_2: Elixir.NeedleTest.Dependency2 }
    }
  end
end

Needle.set_box TestBox

