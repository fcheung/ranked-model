require 'spec_helper'

describe List do

  let(:list_id) { List.create.id}

  describe "rearranging multiple items in a loaded association through nested_attributes" do
    let!(:item_to_move_to_3) { ListItem.create(list_id: list_id, row_order: -134230450)}
    let!(:item_to_move_to_5) { ListItem.create(list_id: list_id, row_order: 1879022747)}
    let!(:item_to_move_to_4) { ListItem.create(list_id: list_id, row_order: 2013249371)}
    let!(:item_to_move_to_2) { ListItem.create(list_id: list_id, row_order: 2147475995)}
    let!(:item_to_move_to_1) { ListItem.create(list_id: list_id, row_order: 2147481734)}

    it "orders items with explicit position" do
      list = List.find list_id

      list.list_items.to_a

      list.update!(
        list_items_attributes: [
          {"id" => item_to_move_to_1.id, "row_order_position" => 0 },
          {"id" => item_to_move_to_2.id, "row_order_position" => 1 },
          {"id" => item_to_move_to_3.id, "row_order_position" => 2 },
          {"id" => item_to_move_to_4.id, "row_order_position" => 3 },
          {"id" => item_to_move_to_5.id, "row_order_position" => 4 }
        ]
      )

      expect(list.reload.list_items).to eq([
        item_to_move_to_1,
        item_to_move_to_2,
        item_to_move_to_3,
        item_to_move_to_4,
        item_to_move_to_5
      ])

    end
  end
end
