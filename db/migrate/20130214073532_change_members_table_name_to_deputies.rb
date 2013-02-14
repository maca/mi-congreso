class ChangeMembersTableNameToDeputies < ActiveRecord::Migration
  def up
    remove_index  :members, :district_id
    remove_index  :members, :party_id
    remove_index  :members, :region_id
    remove_index  :members, :state_id
    rename_table  :members, :deputies
    add_index     :deputies, :district_id
    add_index     :deputies, :party_id
    add_index     :deputies, :region_id
    add_index     :deputies, :state_id

    remove_index  :assistances, :member_id
    rename_column :assistances, :member_id, :deputy_id
    add_index     :assistances, :deputy_id

    remove_index  :commission_memberships, :member_id
    rename_column :commission_memberships, :member_id, :deputy_id
    add_index     :commission_memberships, :deputy_id

    remove_index  :initiatives, :member_id
    rename_column :initiatives, :member_id, :deputy_id
    add_index     :initiatives, :deputy_id

    remove_index  :initiatives_members, :member_id
    remove_index  :initiatives_members, :initiative_id
    rename_column :initiatives_members, :member_id, :deputy_id
    rename_table  :initiatives_members, :deputies_initiatives
    add_index     :deputies_initiatives, :deputy_id
    add_index     :deputies_initiatives, :initiative_id
  end

  def down
    remove_index  :deputies, :district_id
    remove_index  :deputies, :party_id
    remove_index  :deputies, :region_id
    remove_index  :deputies, :state_id
    rename_table  :deputies, :members
    add_index     :members, :district_id
    add_index     :members, :party_id
    add_index     :members, :region_id
    add_index     :members, :state_id

    remove_index  :assistances, :deputy_id
    rename_column :assistances, :deputy_id, :member_id
    add_index     :assistances, :member_id

    remove_index  :commission_memberships, :deputy_id
    rename_column :commission_memberships, :deputy_id, :member_id
    add_index     :commission_memberships, :member_id

    remove_index  :initiatives, :deputy_id
    rename_column :initiatives, :deputy_id, :member_id
    add_index     :initiatives, :member_id

    remove_index  :deputies_initiatives, :deputy_id
    remove_index  :deputies_initiatives, :initiative_id
    rename_table  :deputies_initiatives, :initiatives_members
    rename_column :initiatives_members,  :deputy_id, :member_id
    add_index     :initiatives_members,  :member_id
    add_index     :initiatives_members,  :initiative_id
  end
end
