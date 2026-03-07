PACKAGES := nvim alacritty starship tmux

.PHONY: all install stow restow delete help

all:
	@echo "Invalid argument"

install:
	chmod +x install.sh
	./install.sh

stow:
	@for pkg in $(PACKAGES); do \
		stow -v $$pkg; \
	done

restow:
	@for pkg in $(PACKAGES); do \
		stow -R -v $$pkg; \
	done

delete:
	@for pkg in $(PACKAGES); do \
		stow -D -v $$pkg; \
	done
