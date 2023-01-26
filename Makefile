.PHONY: all
all: .gitignore vendor

.PHONY: clean
clean:
	rm -rf composer.phar vendor

composer.phar:
ifeq (, $(shell which composer 2>/dev/null))
	curl -fsSL 'https://getcomposer.org/installer' | php -- --filename=$@ --stable
else
	ln -s `which composer` $@
endif

vendor: composer.lock composer.phar
	./composer.phar install --prefer-dist
	@touch $@

.gitignore:
	curl -fsSL -o $@ 'https://www.toptal.com/developers/gitignore/api/composer,emacs,vim,visualstudiocode'
	@echo '/composer.lock' >> $@
