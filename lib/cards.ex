defmodule Cards do

  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # List Comprehension: for loop in Elixir
    # for every element in suits do this thing
    # This is a mapping function, whatever is returned from do block
    # is put in a brand new array

    # SOLUTION #1
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)

    # SOLUTION #2
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

    ## Examples
       iex> deck = Cards.create_deck
       iex> Cards.contains?(deck, "Ace of Spades")
       true
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the
    the hand.

    ## Examples
       iex> deck = Cards.create_deck
       iex> {hand, _deck} = Cards.deal(deck, 1)
       iex> hand
       ["Ace of Spades"]
  """

  def deal(deck, hand_size) do
    # Split list into two lists
    # Enum.split Returns a Tuple
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # Calling out Erlang code
    # :erlang has a lot of methods we can use
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      # _reason is a variable, but we don't want to use it
      # so put underscore in front of the name
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
