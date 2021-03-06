class InstitutionsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  # Return the most recent 50 Description Objects uploaded by an instituion.
  def show
    @description_objects = DescriptionObject.where(is_part_of_ssim: "info:fedora/#{@institution.pid}").limit(50).to_a
    show!
  end

  # DELETE /institutions/1
  # DELETE /institutions/1.json
  def destroy
    name = @institution.name
    destroy!(notice: "#{name} was successfully destroyed.")
  end
  
  private
    # If an id is passed through params, use it.  Otherwise default to show a current user's institution.
    def set_institution
      @institution = params[:id].nil? ? Institution.find(current_user.institution_pid) : Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:name)
    end
end
