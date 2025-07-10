class RenameInvoiceColumns < ActiveRecord::Migration[7.2]
  # =============================================
  # PHASE 4: COLUMN RENAMES + COMMENTS (Invoices Table)
  # =============================================
  def up
    change_table :invoices do |t|
      t.rename :numero_bl, :number
      t.rename :montant_facture, :amount
      t.rename :montant_orig, :original_amount
      t.rename :devise, :currency
      t.rename :code_client, :customer_code
      t.rename :nom_client, :customer_name
      t.rename :statut, :status
      t.rename :date_facture, :invoice_date
      t.rename :created_at, :issued_at
      t.rename :id_utilisateur, :created_by_user_id
      t.rename :create_type_utilisateur, :created_by_user_type
      t.rename :id_utilisateur_update, :updated_by_user_id
    end

    change_column_comment :invoices, :number, from: nil, to: "Temporary BL reference for migration"
    change_column_comment :invoices, :amount, from: nil, to: "Final invoiced amount"
    change_column_comment :invoices, :original_amount, from: nil, to: "Original base amount"
    change_column_comment :invoices, :currency, from: nil, to: "Invoice currency"
    change_column_comment :invoices, :customer_code, from: nil, to: "Customer reference code"
    change_column_comment :invoices, :customer_name, from: nil, to: "Customer name at time of invoicing"
    change_column_comment :invoices, :status, from: nil, to: "Invoice status enum"
    change_column_comment :invoices, :invoice_date, from: nil, to: "Invoice date"
    change_column_comment :invoices, :issued_at, from: nil, to: "Timestamp when invoice was issued"
    change_column_comment :invoices, :created_by_user_id, from: nil, to: "ID of user who created the invoice"
    change_column_comment :invoices, :created_by_user_type, from: nil, to: "User who created the invoice"
    change_column_comment :invoices, :updated_by_user_id, from: nil, to: "ID of user who last updated the invoice"
  end

  def down
    change_table :invoices do |t|
      t.rename :number, :numero_bl
      t.rename :amount, :montant_facture
      t.rename :original_amount, :montant_orig
      t.rename :currency, :devise
      t.rename :customer_code, :code_client
      t.rename :customer_name, :nom_client
      t.rename :status, :statut
      t.rename :invoice_date, :date_facture
      t.rename :issued_at, :created_at
      t.rename :created_by_user_id, :id_utilisateur
      t.rename :created_by_user_type, :create_type_utilisateur
      t.rename :updated_by_user_id, :id_utilisateur_update
    end
  end
end
