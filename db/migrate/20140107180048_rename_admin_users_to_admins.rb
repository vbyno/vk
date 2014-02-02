class RenameAdminUsersToAdmins < ActiveRecord::Migration
  class AdminUser < ActiveRecord::Base; end
  class Admin < ActiveRecord::Base; end

  def change
    rename_table :admin_users, :admins
  end
end
