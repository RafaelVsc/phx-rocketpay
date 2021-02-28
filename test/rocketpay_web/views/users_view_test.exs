defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{User, Account}
  alias RocketpayWeb.UsersView
  alias Rocketpay.Users.Create

  test "renders create.json" do
    params = %{
      name: "Rafael",
      password: "123456",
      nickname: "vescio",
      email: "rafael@vescio.com",
      age: 33
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Create.call(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Rafael",
        nickname: "vescio"
      }
    }

    assert expected_response == response
  end
end
