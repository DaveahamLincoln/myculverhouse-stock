puts("MYCULVERHOUSE_STOCK (v1.1.0b codename Diver)
............................................

This message will only appear once per session.  

The way the application is currently set up, every request is tried out by the 
Comfy rack before defaulting to what the base application can handle on its own.

I have disabled these errors because they are confusing and rarely (if ever) 
relevant to what's actually going on on the site.

To reenable these errors (in case you're working on something that is directly 
tied to Comfy), 

      0.  Be sure you are working on something that is directly tied to the CMS.

      1.  Access the cms_content_controller

      2.  Remove the comments from the standard errors

      3.  Comment out 'raise SafeError' where it occurs.

-Dave
............................................")
