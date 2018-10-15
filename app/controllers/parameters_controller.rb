class PatientsController < ApplicationController
  load_and_authorize_resource :institution
  load_and_authorize_resource through: :institution

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private
    def parameters_params
    end
end