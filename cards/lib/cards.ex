defmodule Cards do
  @moduledoc """
    Provides the ability to manage cards
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "File does not exist"
    end
  end

  @doc """
    Composes the `create_deck`, `shuffle`, and `deal` methods.
    And returns a hand of size n

  ## Examples

      iex> hand = Cards.create_hand(5)
      {["Three of Spades", "Two of Hearts", "Two of Spades", "Ace of Hearts",
        "Four of Clubs"],
       ["Three of Clubs", "Ace of Clubs", "Two of Diamonds", "Four of Hearts",
        "Four of Spades", "Two of Clubs", "Ace of Spades", "Ace of Diamonds",
        "Three of Hearts", "Four of Diamonds", "Three of Diamonds"]}
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
