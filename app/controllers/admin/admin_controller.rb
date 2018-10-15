class Admin::AdminController < ApplicationController
  before_action :admin_required
  layout 'admin/layouts/application.haml'

  def admin_required
    authorize! :manage, :all
  end
end