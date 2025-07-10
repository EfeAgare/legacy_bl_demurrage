class AddForeignKeyContraint < ActiveRecord::Migration[7.2]
  def change
    # ========== Invoices ==========
    add_foreign_key :invoices, :bill_of_ladings
    add_index :invoices, :bill_of_lading_id unless index_exists?(:invoices, :bill_of_lading_id)

    # ========== RefundRequests ==========
    add_foreign_key :refund_requests, :bill_of_ladings
    add_index :refund_requests, :bill_of_lading_id unless index_exists?(:refund_requests, :bill_of_lading_id)

    # # ========== BillOfLadings ==========
    add_foreign_key :bill_of_ladings, :customers
    add_index :bill_of_ladings, :customer_id unless index_exists?(:bill_of_ladings, :customer_id)
  end
end
