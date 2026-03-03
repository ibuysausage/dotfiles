all:
	git pull
	cd "scripts/" && ./gensum.sh  && ./setup.sh && ./stow.sh
