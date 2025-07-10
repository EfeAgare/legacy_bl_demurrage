class RenameBillOfLadingColumns < ActiveRecord::Migration[7.2]
  def change
    # =============================================
    # PHASE 2: COLUMN RENAMES + COMMENTS (BillOfLadings Table)
    # =============================================
    change_table :bill_of_ladings do |t|
      t.rename :numero_bl, :number
      t.rename :nbre_20pieds_sec, :dry_20ft_count
      t.rename :nbre_40pieds_sec, :dry_40ft_count
      t.rename :nbre_20pieds_frigo, :reefer_20ft_count
      t.rename :nbre_40pieds_frigo, :reefer_40ft_count
      t.rename :nbre_20pieds_special, :special_20ft_count
      t.rename :nbre_40pieds_special, :special_40ft_count
      t.rename :statut, :status
      t.rename :valide, :is_valid
      t.rename :exempte, :is_exempt
      t.rename :date_upload, :uploaded_at
      t.rename :date_validite, :valid_until
      t.rename :reef, :requires_refrigeration
    end

    change_column_comment :bill_of_ladings, :number, from: nil, to: "Standard BL identifier (was 'numero_bl')"
    change_column_comment :bill_of_ladings, :id, from: nil, to: "Standard Rails primary key naming"
    change_column_comment :bill_of_ladings, :dry_20ft_count, from: nil, to: "Dry 20ft container count"
    change_column_comment :bill_of_ladings, :dry_40ft_count, from: nil, to: "Dry 40ft container count"
    change_column_comment :bill_of_ladings, :reefer_20ft_count, from: nil, to: "Refrigerated 20ft container count"
    change_column_comment :bill_of_ladings, :reefer_40ft_count, from: nil, to: "Refrigerated 40ft container count"
    change_column_comment :bill_of_ladings, :special_20ft_count, from: nil, to: "Special 20ft container count"
    change_column_comment :bill_of_ladings, :special_40ft_count, from: nil, to: "Special 40ft container count"
    change_column_comment :bill_of_ladings, :status, from: nil, to: "Standard Rails enum"
    change_column_comment :bill_of_ladings, :is_valid, from: nil, to: "Boolean flag"
    change_column_comment :bill_of_ladings, :is_exempt, from: nil, to: "Boolean flag"
    change_column_comment :bill_of_ladings, :uploaded_at, from: nil, to: "Upload timestamp"
    change_column_comment :bill_of_ladings, :valid_until, from: nil, to: "Expiration date"
    change_column_comment :bill_of_ladings, :requires_refrigeration, from: nil, to: "Boolean flag for refrigeration container"
  end
end
