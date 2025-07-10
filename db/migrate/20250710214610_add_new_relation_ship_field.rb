class AddNewRelationShipField < ActiveRecord::Migration[7.2]
  def change
    # =============================================
    # PHASE 6: ADD NEW RELATIONSHIP FIELDS
    # =============================================
    add_column :invoices, :bill_of_lading_id, :bigint, comment: "New standard foreign key"
    add_column :refund_requests, :bill_of_lading_id, :bigint, comment: "New standard foreign key"
    add_column :bill_of_ladings, :customer_id, :bigint, comment: "New standard foreign key"

    # =============================================
    # PHASE 7: BACKFILL NEW RELATIONSHIPS
    # =============================================
    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE invoices i
          JOIN bill_of_ladings b ON i.number = b.number
          SET i.bill_of_lading_id = b.id
        SQL

        execute <<~SQL
          UPDATE refund_requests r
          JOIN bill_of_ladings b ON r.number = b.number
          SET r.bill_of_lading_id = b.id
        SQL

        execute <<~SQL
          UPDATE bill_of_ladings
          SET customer_id = id_client
          WHERE customer_id IS NULL
        SQL
      end

      dir.down do
        execute "UPDATE invoices SET bill_of_lading_id = NULL"
        execute "UPDATE refund_requests SET bill_of_lading_id = NULL"
      end
    end
  end
end
