class CmsAdmin::SitesController < CmsAdmin::BaseController
  #mixable_engine extension for ComfortableMexicanSofa

  #Fires to prevent faculty users from accessing the /sites root
  #May need to broaden the scope of this filter.
  before_filter :check_your_privilege, only: [:index]

  private

  def check_your_privilege
    if current_user.nil? 
      redirect_to(root_url)
    else
      if current_user.isFacultyUser
        #Dunno why this doesn't render post-redirect
        #flash.keep[:error] = 'Insufficient permissions to view site index.  Please contact a system 
        #    adminstrator for more information.'
        @site_id = FacultyUser.find_by_userID(current_user.id).cms_site_id
        redirect_to("http://0.0.0.0:3000/cms_admin/sites/#{@site_id}/pages")
      end
    end    
  end

end