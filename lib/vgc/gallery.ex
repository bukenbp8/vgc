defmodule Vgc.Gallery do
  alias VgcWeb.Endpoint

  @unsplash_url Endpoint.url()

  @ids [
    "/images/jusuf.jpg",
    "/images/enrico.jpg",
    "/images/stand_up.jpg",
    "/images/side_control.jpg"
  ]

  # def thumb_url(id), do: image_url(id, %{})
  # def large_url(id), do: image_url(id, %{})

  def image_ids(), do: @ids

  def first_id(ids \\ @ids) do
    List.first(ids)
  end

  def prev_image_id(ids \\ @ids, id) do
    Enum.at(ids, prev_index(ids, id))
  end

  def prev_index(ids, id) do
    ids
    |> Enum.find_index(&(&1 == id))
    |> Kernel.-(1)
  end

  def next_image_id(ids \\ @ids, id) do
    Enum.at(ids, next_index(ids, id), first_id(ids))
  end

  def next_index(ids, id) do
    ids
    |> Enum.find_index(&(&1 == id))
    |> Kernel.+(1)
  end

  def image_url(image_id) do
    URI.parse(@unsplash_url)
    |> URI.merge(image_id)
    |> URI.to_string()
  end
end
