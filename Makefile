status:
	@echo "Check ~/.zshrc"
	@-ls -la ~ | grep .zshrc
	@echo
	@echo "Check ~/.p10k.zsh"
	@-ls -la ~ | grep .p10k.zsh
	@echo
	@echo "Check ~/.config/wezterm"
	@-ls -la ~/.config/wezterm
	@echo
	@echo "Check ~/.config/nvim"
	@-ls -la ~/.config/nvim
	@echo

install:
	stow --target=${HOME} zsh p10k nvim wezterm

backup:
	@echo "Backup ~/.zshrc"
	@-mv ~/.zshrc ~/.zshrc.bak
	@echo
	@echo "Backup ~/.p10k.zsh"
	@-mv ~/.p10k.zsh ~/.p10k.zsh.bak
	@echo
	@echo "Backup ~/.config/wezterm"
	@-mv ~/.config/wezterm ~/.config/wezterm.bak
	@echo
	@echo "Backup ~/.config/nvim"
	@-mv ~/.config/nvim ~/.config/nvim.bak
	@echo

