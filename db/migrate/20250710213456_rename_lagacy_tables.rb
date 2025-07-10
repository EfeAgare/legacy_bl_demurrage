class RenameLagacyTables < ActiveRecord::Migration[7.2]
  def change
    # =============================================
    # PHASE 1: TABLE RENAMES (Legacy → Rails Naming)
    # =============================================
    rename_table :bl, :bill_of_ladings if table_exists?(:bl) && !table_exists?(:bill_of_ladings)
    rename_table :client, :customers if table_exists?(:client) && !table_exists?(:customers)
    rename_table :facture, :invoices if table_exists?(:facture) && !table_exists?(:invoices)
    rename_table :remboursement, :refund_requests if table_exists?(:remboursement) && !table_exists?(:refund_requests)

    # =============================================
    # PHASE 2: STANDARDIZE PRIMARY KEYS
    # =============================================
    change_column :bill_of_ladings, :id_bl, :bigint, null: false, auto_increment: true if column_exists?(:bill_of_ladings, :id_bl)
    rename_column :bill_of_ladings, :id_bl, :id if column_exists?(:bill_of_ladings, :id_bl)

    change_column :customers, :id_client, :bigint, null: false, auto_increment: true if column_exists?(:customers, :id_client)
    rename_column :customers, :id_client, :id if column_exists?(:customers, :id_client)

    change_column :refund_requests, :id_remboursement, :bigint, null: false, auto_increment: true if column_exists?(:refund_requests, :id_remboursement)
    rename_column :refund_requests, :id_remboursement, :id if column_exists?(:refund_requests, :id_remboursement)

    change_column :invoices, :id_facture, :bigint, null: false, auto_increment: true if column_exists?(:invoices, :id_facture)
    rename_column :invoices, :id_facture, :id if column_exists?(:invoices, :id_facture)
  end
end
