defmodule NeedleTest do
  use ExUnit.Case
  doctest Needle

  defmodule Something do
    use Needle
    defdependency :dep_1

    def next do
      dep_1
    end
  end

  defmodule Dependency1 do
    use Needle
    defdependency :dep_2

    def next do
      dep_2
    end
  end

  defmodule Dependency2 do
    def value do
      :success
    end
  end

  test "the truth" do
    assert Something.next.next.value == :success
  end
end
