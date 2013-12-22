require 'comfortable_mexican_sofa'

module ComfortableMexicanSofa
	class CmsAdmin
		class SitesController
			def crafty_create(path,label)
				@site = Cms::Site.new
				@site.hostname ||= request.host.downcase
				@site.update_attributes(:path => path, :label => label)
				@site.save!
			end
		end
	end
end