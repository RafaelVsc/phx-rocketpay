defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Rafael",
        password: "123456",
        nickname: "vescio",
        email: "rafael@vescio.com",
        age: 33
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Rafael", age: 33, id: ^user_id} = user
    end

    test "when there are invalid params, returns a error" do
      params = %{
        name: "Rafael",
        # password: "123456",
        nickname: "vescio",
        email: "rafael@banana.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_rersponse = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert expected_rersponse == errors_on(changeset)
    end
  end
end
