defmodule Theclap.Applause do
  @moduledoc """
  The Applause context.
  """

  import Ecto.Query, warn: false
  alias Theclap.Repo

  alias Theclap.Applause.Clap

  @doc """
  Returns the list of claps.

  ## Examples

      iex> list_claps()
      [%Clap{}, ...]

  """
  def list_claps do
    Repo.all(Clap)
  end

  @doc """
  Gets a single clap.

  Raises `Ecto.NoResultsError` if the Clap does not exist.

  ## Examples

      iex> get_clap!(123)
      %Clap{}

      iex> get_clap!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clap!(id), do: Repo.get!(Clap, id)

  @doc """
  Creates a clap.

  ## Examples

      iex> create_clap(%{field: value})
      {:ok, %Clap{}}

      iex> create_clap(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clap(attrs \\ %{}) do
    %Clap{}
    |> Clap.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clap.

  ## Examples

      iex> update_clap(clap, %{field: new_value})
      {:ok, %Clap{}}

      iex> update_clap(clap, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clap(%Clap{} = clap, attrs) do
    clap
    |> Clap.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clap.

  ## Examples

      iex> delete_clap(clap)
      {:ok, %Clap{}}

      iex> delete_clap(clap)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clap(%Clap{} = clap) do
    Repo.delete(clap)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clap changes.

  ## Examples

      iex> change_clap(clap)
      %Ecto.Changeset{data: %Clap{}}

  """
  def change_clap(%Clap{} = clap, attrs \\ %{}) do
    Clap.changeset(clap, attrs)
  end

  def give_me_the_claps!(user_id) do
    query =
      from(claps in Clap,
        where: claps.user_id == ^user_id
      )

    Repo.aggregate(query, :count)
  end

  def give_me_the_claps! do
    Repo.aggregate(Clap, :count)
  end
end
