defmodule Cards do
  @moduledoc """
    Provides the ability to manage cards
  """

  @doc """
    Created a prepopulated deck with values and suits

  ## Examples

      iex(1)> Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
       "Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
       "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds", "Four of Diamonds"]
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

  @doc """
    Checks to see if a card is in a deck

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck, "Two of Hearts")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Deals a collection of cards of a given hand size

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.deal(deck, 5)
      {["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
        "Ace of Clubs"],
       ["Two of Clubs", "Three of Clubs", "Four of Clubs", "Ace of Hearts",
        "Two of Hearts", "Three of Hearts", "Four of Hearts", "Ace of Diamonds",
        "Two of Diamonds", "Three of Diamonds", "Four of Diamonds"]}
  """
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
    And returns a hand of size n.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
