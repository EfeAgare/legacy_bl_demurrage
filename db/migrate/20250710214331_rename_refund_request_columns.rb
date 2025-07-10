class RenameRefundRequestColumns < ActiveRecord::Migration[7.2]
  # =============================================
  # PHASE 5: COLUMN RENAMES + COMMENTS (RefundRequests Table)
  # =============================================
  def up
    change_table :refund_requests do |t|
      t.rename :numero_bl, :number
      t.rename :montant_demande, :amount_requested
      t.rename :refund_amount, :amount_approved
      t.rename :deduction, :deduction
      t.rename :statut, :status
      t.rename :id_transitaire, :forwarder_id
      t.rename :id_transitaire_maison, :house_forwarder_id
      t.rename :transitaire_notifie, :forwarder_notified
      t.rename :maison_notifie, :house_forwarder_notified
      t.rename :banque_notifie, :bank_notified
      t.rename :date_demande, :requested_at
      t.rename :date_refund_traite, :processed_at
      t.rename :type_paiement, :payment_type
      t.rename :pret, :is_loan
      t.rename :soumis, :is_submitted
      t.rename :consignee_code, :consignee_number
      t.rename :refund_party_name, :refund_party_name
      t.rename :beneficiaire, :beneficiary
      t.rename :reason_for_refund, :refund_reason
      t.rename :remarks, :remarks
      t.rename :co_code, :company_code
      t.rename :zm_doc_no, :zm_document_number
      t.rename :gl_posting_doc, :gl_posting_document
      t.rename :clearing_doc, :clearing_document
      t.rename :email_address, :email
      t.rename :type_depotage, :unpacking_type
      t.rename :accord_client, :client_approval
      t.rename :comment, :internal_comment
      t.rename :reference, :reference_number
      t.rename :date_agent_notified, :agent_notified_at
      t.rename :date_agency_notified, :agency_notified_at
      t.rename :date_client_notified, :client_notified_at
      t.rename :date_banque_notified, :bank_notified_at
      t.rename :email_agency, :agency_email
      t.rename :email_client, :client_email
    end

    change_column_comment :refund_requests, :number, from: nil, to: "Legacy BL number from old system"
    change_column_comment :refund_requests, :amount_requested, from: nil, to: "Amount requested for refund"
    change_column_comment :refund_requests, :amount_approved, from: nil, to: "Amount approved for refund"
    change_column_comment :refund_requests, :deduction, from: nil, to: "Any deductions applied to refund"
    change_column_comment :refund_requests, :status, from: nil, to: "Refund request status (enum)"
    change_column_comment :refund_requests, :forwarder_id, from: nil, to: "ID of external forwarder"
    change_column_comment :refund_requests, :house_forwarder_id, from: nil, to: "ID of in-house forwarder"
    change_column_comment :refund_requests, :forwarder_notified, from: nil, to: "Boolean: forwarder has been notified"
    change_column_comment :refund_requests, :house_forwarder_notified, from: nil, to: "Boolean: house forwarder notified"
    change_column_comment :refund_requests, :bank_notified, from: nil, to: "Boolean: bank notified"
    change_column_comment :refund_requests, :requested_at, from: nil, to: "Date the refund was requested"
    change_column_comment :refund_requests, :processed_at, from: nil, to: "Date the refund was processed"
    change_column_comment :refund_requests, :payment_type, from: nil, to: "Type of payment (e.g. cash, transfer)"
    change_column_comment :refund_requests, :is_loan, from: nil, to: "Boolean: was this a loan?"
    change_column_comment :refund_requests, :is_submitted, from: nil, to: "Boolean: submitted to relevant party"
    change_column_comment :refund_requests, :consignee_number, from: nil, to: "Consignee customer reference number"
    change_column_comment :refund_requests, :refund_party_name, from: nil, to: "Name of refund recipient"
    change_column_comment :refund_requests, :beneficiary, from: nil, to: "Bank beneficiary name"
    change_column_comment :refund_requests, :refund_reason, from: nil, to: "Reason provided for the refund"
    change_column_comment :refund_requests, :remarks, from: nil, to: "Extra remarks on refund"
    change_column_comment :refund_requests, :company_code, from: nil, to: "SAP or ERP company code"
    change_column_comment :refund_requests, :zm_document_number, from: nil, to: "ZM document number from finance"
    change_column_comment :refund_requests, :gl_posting_document, from: nil, to: "GL posting document ID"
    change_column_comment :refund_requests, :clearing_document, from: nil, to: "Document used to clear the refund"
    change_column_comment :refund_requests, :email, from: nil, to: "Email address for correspondence"
    change_column_comment :refund_requests, :unpacking_type, from: nil, to: "Depotage/unpacking type"
    change_column_comment :refund_requests, :client_approval, from: nil, to: "Boolean: client approved refund"
    change_column_comment :refund_requests, :internal_comment, from: nil, to: "Internal use comment"
    change_column_comment :refund_requests, :reference_number, from: nil, to: "Reference identifier"
    change_column_comment :refund_requests, :agent_notified_at, from: nil, to: "Date agent was notified"
    change_column_comment :refund_requests, :agency_notified_at, from: nil, to: "Date agency was notified"
    change_column_comment :refund_requests, :client_notified_at, from: nil, to: "Date client was notified"
    change_column_comment :refund_requests, :bank_notified_at, from: nil, to: "Date bank was notified"
    change_column_comment :refund_requests, :agency_email, from: nil, to: "Email of agency"
    change_column_comment :refund_requests, :client_email, from: nil, to: "Email of client"
  end

  def down
    change_table :refund_requests do |t|
      t.rename :number, :numero_bl
      t.rename :amount_requested, :montant_demande
      t.rename :amount_approved, :refund_amount
      t.rename :deduction, :deduction
      t.rename :status, :statut
      t.rename :forwarder_id, :id_transitaire
      t.rename :house_forwarder_id, :id_transitaire_maison
      t.rename :forwarder_notified, :transitaire_notifie
      t.rename :house_forwarder_notified, :maison_notifie
      t.rename :bank_notified, :banque_notifie
      t.rename :requested_at, :date_demande
      t.rename :processed_at, :date_refund_traite
      t.rename :payment_type, :type_paiement
      t.rename :is_loan, :pret
      t.rename :is_submitted, :soumis
      t.rename :consignee_number, :consignee_code
      t.rename :refund_party_name, :refund_party_name
      t.rename :beneficiary, :beneficiaire
      t.rename :refund_reason, :reason_for_refund
      t.rename :remarks, :remarks
      t.rename :company_code, :co_code
      t.rename :zm_document_number, :zm_doc_no
      t.rename :gl_posting_document, :gl_posting_doc
      t.rename :clearing_document, :clearing_doc
      t.rename :email, :email_address
      t.rename :unpacking_type, :type_depotage
      t.rename :client_approval, :accord_client
      t.rename :internal_comment, :comment
      t.rename :reference_number, :reference
      t.rename :agent_notified_at, :date_agent_notified
      t.rename :agency_notified_at, :date_agency_notified
      t.rename :client_notified_at, :date_client_notified
      t.rename :bank_notified_at, :date_banque_notified
      t.rename :agency_email, :email_agency
      t.rename :client_email, :email_client
    end
  end
end
