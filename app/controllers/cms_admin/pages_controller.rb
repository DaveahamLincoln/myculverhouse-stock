class CmsAdmin::PagesController < CmsAdmin::BaseController
	#mixable_engine extension for ComfortableMexicanSofa

	#May need to broaden the scope of this filter.
	before_filter :check_your_privilege, only: [:index, :new]

	private

	def check_your_privilege
	    if current_user.nil? 
	      redirect_to(root_url)
	    else
	      if current_user.isFacultyUser
	        #Blocks faculty users from accessing their site's pages index unless the cms_site_enabled bit has been set manually in the database.
	        unless FacultyUser.find_by_userID(current_user.id).cms_site_enabled
	          redirect_to(root_url)
	        end
	      end
	    end    
	end
end
