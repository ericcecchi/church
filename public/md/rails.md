# Rails setup guide
This guide was generated automagically by the server from a Markdown document. For real. You can download it [here](/md/rails.md) if you don't believe me.

This guide is really just a summary of commands to get a basic functional app with user authentication. I've also included a list of tools I've found so far that seem to be incredibly useful in Rails development. For a much more detailed tutorial, go [here](https://github.com/RailsApps/rails3-mongoid-devise/wiki/Tutorial).

### [Church on Github](https://github.com/hueyha/church)

## Git ridin' teh rails
### 1. [Git](//git-scm.com/) it.

~~~.console
$ git --version # Make sure you're not a nub without git
~~~

### 2. [RVM.](//beginrescueend.com/)

~~~.console
$ console -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
$ source ~/.console_profile # Or restart Terminal
~~~

### 3. I <3 [Rubies.](//www.ruby-lang.org/en/)

~~~.console
$ rvm install 1.9.3
$ rvm use 1.9.3
$ ruby -v # Should say 1.9.3p#
$ rvm --default 1.9.3 # Make it the default
~~~

### 4. [Gems.](//rubygems.org/)

~~~.console
$ gem update --system # may need to be administrator or root
~~~

### 5. [Rails.](//rubyonrails.org/)

~~~.console
$ gem install rails
~~~

### 6. [Homebrew.](//mxcl.github.com/homebrew/)

~~~.console
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
~~~

### 7. [MongoDB.](//www.mongodb.org/)

~~~.console
$ brew install mongodb
$ sudo mkdir -p /data/db # Why didn't the installer do this? I dunno.
$ sudo chown `id -u` /data/db
$ mongod # Start the database daemon. Leave it running in a terminal.
~~~

### 8. [Skeleton.](https://github.com/RailsApps/rails3-mongoid-devise/wiki/Tutorial)

~~~.console
$ cd /path/to/apps
$ rails new myapp -m https://github.com/RailsApps/rails3-application-templates/raw/master/rails3-mongoid-devise-template.rb -T -O
$ cd myapp
~~~

### 9. WHAM! BOOM! [POW!](//pow.cx)
Make your app available at myapp.dev.

~~~.console
$ gem install powder
$ powder install
$ powder link myapp
~~~

### 10. [Mongoid.](//mongoid.org/)

~~~.console
$ rails generate mongoid:config
~~~

### 11. [Devise.](//github.com/plataformatec/devise)

~~~.console
$ rails generate devise:install
$ rails generate devise User
~~~

To prevent password logging, modify the file **config/application.rb** to include:

~~~
config.filter_parameters += [:password, :password_confirmation]
~~~

## Skeleton

### [MongoDB](//www.mongodb.org/)
NoSQL. Fast. Document-based. BSON. Scalable.

### [Mongoid](//mongoid.org/)
No more migrations. From model to database.

### [Devise](//github.com/plataformatec/devise)
Quick and easy user authenication.

### [Twitter bootstrap](//twitter.github.com/bootstrap)
HTML5, CSS3, (fairly) clean markup, and it's quite pretty.

## Other Stuff
### [Powder](https://github.com/Rodreegez/powder)
As if using Pow wasn't easy enough already.

~~~.console
$ gem install powder
~~~

### [Github for Mac](//mac.github.com/)
They almost make it too easy.

### [Markdown + Rails = Heaven](//railscasts.com/episodes/272-markdown-with-redcarpet)

### [iA Writer](//www.iawriter.com/)
What?!? It's not free! I paid $2 for it, but it's definitely worth whatever they're charging for it now.

### Use the right version of Ruby
~~~.console
$ rvm --default 1.9.3 # Changes default for rvm
$ cd /path/to/app
$ rvm --rvmrc --create 1.9.3 # Creates .rvmrc for project
~~~

### No docs when installing gems
~~~.console
$ cd ~
$ mate .gemrc
~~~

Add this line:

~~~.console
gem: --no-ri --no-rdoc
~~~
