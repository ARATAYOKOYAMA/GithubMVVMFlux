setup:
	brew update
	brew upgrage
	brew install rbenv ruby-build
	rbenv -v
	rbenv install 2.6.3
	rbenv local 2.6.3
	rbenv init
	echo eval "$(rbenv init -)" > ~/.bash_profile
	source ~/.bash_profile
	rbuy -v

install:
	echo "brew update"
	brew update
	echo "brew upgrade"
	brew upgrade
	echo "bundler install"
	sudo gem install bundler
	echo "vendor/bundle install"
	bundle install --path vendor/bundle
	
