# Rails setup guide
## Git ridin' teh rails
### 1. Git it.

~~~.console
$ git --version # Make sure you're not a nub without git
~~~

### 2. RVM.

~~~.console
$ console -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
$ source ~/.console_profile # Or restart Terminal
~~~

### 3. I <3 Rubies.

~~~.console
$ rvm install 1.9.3
$ rvm use 1.9.3
$ ruby -v # Should say 1.9.3p#
$ rvm --default 1.9.3 # Make it the default
~~~

### 4. Gems.

~~~.console
$ gem update --system # may need to be administrator or root
~~~

### 5. Rails.

~~~.console
$ gem install rails
~~~

### 6. Homebrew.

~~~.console
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
~~~

### 7. MongoDB.

~~~.console
$ brew install mongodb
$ sudo mkdir -r /data/db # Why didn't the installer do this? I dunno.
$ sudo chown `id -u` /data/db
$ mongod # Start the database daemon. Leave it running in a terminal.
~~~

### 8. Skeleton.

~~~.console
$ cd /path/to/apps
$ rails new myapp -m https://github.com/RailsApps/rails3-application-templates/raw/master/rails3-mongoid-devise-template.rb -T -O
$ cd myapp
~~~

### 9. Mongoid

~~~.console
$ rails generate mongoid:config
~~~

## Skeleton
This is good:
[click](https://github.com/RailsApps/rails3-mongoid-devise/wiki/Tutorial)

### MongoDB
NoSQL. Fast. Document-based. BSON. Scalable.

### Mongoid
No more migrations. From model to database.

### Devise
Quick and easy user authenication.

### Twitter bootstrap
HTML5, CSS3, clean markup, and it's quite pretty.


## Other Stuff
### Markdown + Rails = Heaven
[click](http://railscasts.com/episodes/272-markdown-with-redcarpet)

### Use the right version of Ruby
~~~.console
rvm --default 1.9.3 # Changes default for rvm
cd /path/to/app
rvm --rvmrc --create 1.9.3 # Creates .rvmrc for project
~~~

### No docs when installing gems
~~~.console
cd ~
mate .gemrc
~~~

Add this line:

~~~.console
gem: --no-ri --no-rdoc
~~~