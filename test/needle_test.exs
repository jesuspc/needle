defmodule NeedleTest do
  use ExUnit.Case
  doctest Needle

  defmodule Something do
    use Needle
    defdependency :d1

    def next do
      d1
    end
  end

  defmodule Dependency1 do
    use Needle
    defdependency :d2

    def next do
      d2
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
