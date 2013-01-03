stasis-blog-template
====================

A dead simple static blog using stasis and bootstrap.

Start writing posts in textile format. No metadata required. 


Requirements
------------

This framework requires stasis (http://stasis.me)

* Install stasis _gem install stasis_
* Install nokogiri _gem install nokogiri_



Clone the framework

    git clone git@github.com:vivekrajan/stasis-blog-template.git 
  
The action happens in two places

* the blog directory, all your posts go here as post.html.textile - the directory name is the URL
* the layout directory, uses bootstrap to layout and typo your blog posts

Creating a post
----------------

- Create a subdirectory under /blog/my-third-post
- Write and save your post in post.html.textile within that directory
- You can optionally create an images subdirectory for each post to hold the media

Type 

    stasis

Now your new blog post is ready under the public directory. 

How
----

This framework follows a simple set of rules that allow you to write blog posts without worrying about metadata.

- The directory name will be the permalink URL
- The file modification time will be the published date
- The linux user who created the file will be the author
- An index of posts is automatically created
- A list of most recent blog posts is also automatically created
- A front page contains the most recent blog posts

The secret is Nokogiri
-----------------------

If you know Ruby, you can achieve amazing things with stasis and bootstrap. 
The secret magic lies in knowing how to use Nokogiri (the HTML manipulator).
Check out the code in ````blog/controller.rb````  where we manipulate the posts. 

Hope this framework helps you get started !




