class RenameCustomerColumns < ActiveRecord::Migration[7.2]
  def change
    # =============================================
    # PHASE 3: COLUMN RENAMES + COMMENTS (Customers Table)
    # =============================================
    change_table :customers do |t|
      t.rename :nom, :name
      t.rename :code_client, :code
      t.rename :nom_groupe, :group_name
      t.rename :paie_caution, :pays_deposit
      t.rename :freetime_frigo, :reefer_freetime_days
      t.rename :freetime_sec, :dry_freetime_days
      t.rename :prioritaire, :has_priority
      t.rename :salesrepid, :sales_representative_id
      t.rename :financerepid, :finance_representative_id
      t.rename :cservrepid, :customer_service_representative_id
      t.rename :date_validite, :valid_until
    end

    change_column_comment :customers, :name, from: nil, to: "Customer full name"
    change_column_comment :customers, :code, from: nil, to: "Customer reference code"
    change_column_comment :customers, :group_name, from: nil, to: "Customer group name"
    change_column_comment :customers, :pays_deposit, from: nil, to: "Boolean: pays deposit"
    change_column_comment :customers, :reefer_freetime_days, from: nil, to: "Free days for reefer containers"
    change_column_comment :customers, :dry_freetime_days, from: nil, to: "Free days for dry containers"
    change_column_comment :customers, :has_priority, from: nil, to: "Boolean: has priority service"
    change_column_comment :customers, :sales_representative_id, from: nil, to: "Foreign key for sales representative"
    change_column_comment :customers, :finance_representative_id, from: nil, to: "Foreign key for finance representative"
    change_column_comment :customers, :customer_service_representative_id, from: nil, to: "Foreign key for customer service rep"
    change_column_comment :customers, :valid_until, from: nil, to: "Account validity date"
  end
end
