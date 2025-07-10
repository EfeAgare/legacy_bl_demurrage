# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_07_10_214837) do
  create_table "bill_of_ladings", id: { comment: "Standard Rails primary key naming" }, charset: "latin1", force: :cascade do |t|
    t.integer "id_upload"
    t.datetime "uploaded_at", precision: nil, comment: "Upload timestamp"
    t.string "number", limit: 9, null: false, comment: "Standard BL identifier (was 'numero_bl')"
    t.integer "id_client"
    t.string "consignee_code", limit: 20
    t.string "consignee_name", limit: 60
    t.string "notified_code", limit: 20
    t.string "notified_name", limit: 60
    t.string "vessel_name", limit: 30
    t.string "vessel_voyage", limit: 10
    t.datetime "arrival_date", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.integer "freetime"
    t.integer "dry_20ft_count", comment: "Dry 20ft container count"
    t.integer "dry_40ft_count", comment: "Dry 40ft container count"
    t.integer "reefer_20ft_count", comment: "Refrigerated 20ft container count"
    t.integer "reefer_40ft_count", comment: "Refrigerated 40ft container count"
    t.integer "special_20ft_count", comment: "Special 20ft container count"
    t.integer "special_40ft_count", comment: "Special 40ft container count"
    t.string "requires_refrigeration", limit: 1, default: "", comment: "Boolean flag for refrigeration container"
    t.string "type_depotage", limit: 30
    t.datetime "valid_until", precision: nil, comment: "Expiration date"
    t.string "status", limit: 30, comment: "Standard Rails enum"
    t.boolean "is_exempt", default: false, null: false, comment: "Boolean flag"
    t.boolean "blocked_for_refund", default: false, null: false
    t.string "reference", limit: 60
    t.text "comment"
    t.boolean "is_valid", comment: "Boolean flag"
    t.string "released_statut", limit: 20
    t.text "released_comment"
    t.string "operator", limit: 20
    t.string "atp", limit: 30
    t.boolean "consignee_caution", default: false, null: false
    t.string "service_contract", limit: 200
    t.string "bank_account", limit: 30
    t.string "bank_name", limit: 30
    t.string "emails", limit: 60
    t.string "telephone", limit: 20
    t.string "place_receipt", limit: 60
    t.string "place_delivery", limit: 60
    t.string "port_loading", limit: 60
    t.string "port_discharge", limit: 60
    t.bigint "customer_id", comment: "New standard foreign key"
    t.index ["arrival_date"], name: "arrival_date"
    t.index ["consignee_code"], name: "consignee_code"
    t.index ["consignee_name"], name: "consignee_name"
    t.index ["customer_id"], name: "fk_rails_8b75998e07"
    t.index ["number"], name: "numero_bl"
    t.index ["requires_refrigeration"], name: "reef"
  end

  create_table "customers", charset: "latin1", force: :cascade do |t|
    t.string "name", limit: 60, null: false, comment: "Customer full name"
    t.string "statut", limit: 20
    t.string "code", limit: 20, comment: "Customer reference code"
    t.string "group_name", limit: 150, null: false, comment: "Customer group name"
    t.boolean "pays_deposit", null: false, comment: "Boolean: pays deposit"
    t.integer "reefer_freetime_days", comment: "Free days for reefer containers"
    t.integer "dry_freetime_days", comment: "Free days for dry containers"
    t.boolean "has_priority", comment: "Boolean: has priority service"
    t.integer "sales_representative_id", comment: "Foreign key for sales representative"
    t.integer "finance_representative_id", comment: "Foreign key for finance representative"
    t.integer "customer_service_representative_id", comment: "Foreign key for customer service rep"
    t.datetime "valid_until", precision: nil, comment: "Account validity date"
    t.string "operator", limit: 20
  end

  create_table "invoices", charset: "utf8mb3", force: :cascade do |t|
    t.string "reference", limit: 10, null: false
    t.string "number", limit: 9, null: false, comment: "Temporary BL reference for migration"
    t.string "customer_code", limit: 20, null: false, comment: "Customer reference code"
    t.string "customer_name", limit: 60, null: false, comment: "Customer name at time of invoicing"
    t.decimal "amount", precision: 12, null: false, comment: "Final invoiced amount"
    t.decimal "original_amount", precision: 12, scale: 2, comment: "Original base amount"
    t.string "currency", limit: 6, default: "XOF", comment: "Invoice currency"
    t.string "status", limit: 10, default: "init", null: false, comment: "Invoice status enum"
    t.datetime "invoice_date", precision: nil, null: false, comment: "Invoice date"
    t.integer "created_by_user_id", null: false, comment: "ID of user who created the invoice"
    t.string "created_by_user_type", limit: 20, comment: "User who created the invoice"
    t.datetime "issued_at", precision: nil, null: false, comment: "Timestamp when invoice was issued"
    t.integer "updated_by_user_id", comment: "ID of user who last updated the invoice"
    t.datetime "updated_at", precision: nil
    t.bigint "bill_of_lading_id", comment: "New standard foreign key"
    t.index ["bill_of_lading_id"], name: "fk_rails_3a96d0abe2"
    t.index ["reference"], name: "unique_reference", unique: true
  end

  create_table "refund_requests", charset: "latin1", force: :cascade do |t|
    t.string "number", limit: 9, null: false, comment: "Legacy BL number from old system"
    t.string "amount_requested", limit: 15, comment: "Amount requested for refund"
    t.string "amount_approved", limit: 15, comment: "Amount approved for refund"
    t.string "deduction", limit: 15, comment: "Any deductions applied to refund"
    t.string "status", limit: 10, default: "PENDING", comment: "Refund request status (enum)"
    t.integer "forwarder_id", null: false, comment: "ID of external forwarder"
    t.integer "house_forwarder_id", comment: "ID of in-house forwarder"
    t.boolean "forwarder_notified", comment: "Boolean: forwarder has been notified"
    t.boolean "house_forwarder_notified", comment: "Boolean: house forwarder notified"
    t.boolean "bank_notified", comment: "Boolean: bank notified"
    t.datetime "requested_at", precision: nil, comment: "Date the refund was requested"
    t.datetime "processed_at", precision: nil, comment: "Date the refund was processed"
    t.string "payment_type", limit: 10, comment: "Type of payment (e.g. cash, transfer)"
    t.string "is_loan", limit: 10, comment: "Boolean: was this a loan?"
    t.string "is_submitted", limit: 10, comment: "Boolean: submitted to relevant party"
    t.string "consignee_number", limit: 14, comment: "Consignee customer reference number"
    t.string "refund_party_name", limit: 200, comment: "Name of refund recipient"
    t.string "beneficiary", limit: 20, comment: "Bank beneficiary name"
    t.string "deposit_amount", limit: 15
    t.string "refund_reason", limit: 200, comment: "Reason provided for the refund"
    t.string "remarks", limit: 250, comment: "Extra remarks on refund"
    t.string "company_code", limit: 20, comment: "SAP or ERP company code"
    t.text "zm_document_number", comment: "ZM document number from finance"
    t.string "gl_posting_document", limit: 15, comment: "GL posting document ID"
    t.string "clearing_document", limit: 15, comment: "Document used to clear the refund"
    t.string "email", limit: 60, comment: "Email address for correspondence"
    t.string "unpacking_type", limit: 40, comment: "Depotage/unpacking type"
    t.boolean "client_approval", comment: "Boolean: client approved refund"
    t.text "internal_comment", comment: "Internal use comment"
    t.string "reference_number", limit: 30, comment: "Reference identifier"
    t.datetime "agent_notified_at", precision: nil, comment: "Date agent was notified"
    t.datetime "agency_notified_at", precision: nil, comment: "Date agency was notified"
    t.datetime "client_notified_at", precision: nil, comment: "Date client was notified"
    t.datetime "bank_notified_at", precision: nil, comment: "Date bank was notified"
    t.string "agency_email", limit: 60, comment: "Email of agency"
    t.string "client_email", limit: 60, comment: "Email of client"
    t.bigint "bill_of_lading_id", comment: "New standard foreign key"
    t.index ["bill_of_lading_id"], name: "fk_rails_1a72725b51"
    t.index ["number"], name: "numero_bl"
    t.index ["refund_reason"], name: "reason_for_refund"
    t.index ["requested_at"], name: "date_demande"
    t.index ["status"], name: "statut"
  end

  add_foreign_key "bill_of_ladings", "customers"
  add_foreign_key "invoices", "bill_of_ladings"
  add_foreign_key "refund_requests", "bill_of_ladings"
end
