defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    # |> pipe operator pega o retorno da função anterior e passa como primeiro argumento para próxima função
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
    # file = File.read("#{filename}.csv")
    # handle_file(file)
  end

  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()
    {:ok, %{result: result}}
    # result = String.split(result, ",")
    # result = Enum.map(result, fn number -> String.to_integer(number) end)
    # result = Enum.sum(result)
    # result
  end
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid File!"}}

end
