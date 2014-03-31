#This is a fragment for tabbed navigation.  I can't seem to get it working properly.  Will tinker with it a 
#bit.

# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name, item| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false
  
  # If this option is set to true, all item names will be considered as safe (passed through html_safe). Defaults to false.
  # navigation.consider_item_names_as_safe = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    primary.item :admin_tab, 'Admin', :if => Proc.new {current_user.isSuperUser?} do |sub|
      sub.item :edit_user_tab, 'User Admin', '/users'
      sub.item :edit_sites_tab, 'Edit Sites', '/cms_admin/sites'
      sub.item :edit_centers_tab, 'Edit Centers', '/centers'
      sub.item :edit_departments_tab, 'Edit Departments', '/departments'
      sub.item :edit_programs_tab, 'Edit Programs', '/programs'
    end

    primary.item :communications_tab, 'Communications', :if => Proc.new {current_user.isCommunicationsUser?} do |sub|
      sub.item :approve_action_items_tab, 'Approve Action Items', '/action_items'
      sub.item :blog_admin_tab, 'Blog Admin', '/blog/monologue'
    end

    primary.item :faculty_tab, 'Faculty', :if => Proc.new {current_user.isFacultyUser?} do |sub|
      sub.item :edit_my_site_tab, 'Edit My Site', '/cms_admin', :if => Proc.new {FacultyUser.find_by_userID(current_user.id).cms_site_enabled?}
      sub.item :edit_my_publications_tab, 'Edit My Publications', '/publications'
      sub.item :submit_calendar_item_tab, 'Submit Calendar Item', '/calendar_items/new'
      sub.item :submit_news_items_tab, 'Submit News Item', '/news_items/new'
    end

    primary.item :general, 'General' do |sub|
      sub.item :calendar_tab, 'Master Calendar', '/calendar'
      sub.item :news_tab, 'News', 'News Feed', '/news'
      sub.item :faculty_index_tab, 'Faculty Index', '/faculty'
      sub.item :blog_tab, 'Blog', '/blog'
    end

    primary.item :tech, 'Tech' do |sub|
      sub.item :trouble_tickets_tab, 'Trouble Tickets', '/equipment'
      sub.item :computer_programs_tab, 'Computer Programs', '/computer_programs'
      sub.item :locations_tab, 'Locations', '/locations'
      sub.item :equipment_tab, 'Equipment', '/equipment'
    end

    # Add an item which has a sub navigation (same params, but with block)
    #primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      #sub_nav.item :key_2_1, 'name', url, options
    #end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify html attributes to attach to this particular level
    # works for all levels of the menu
    # primary.dom_attributes = {id: 'menu-id', class: 'menu-class'}

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
