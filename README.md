# dhawk1981/dotfiles

Welcome to my chaotic little corner of the internet: a collection of dotfiles, random snippets, half-remembered shell hacks, and CSS experiments that probably came from "some Stack Overflow thread I can't find anymore." This is my start on dotfiles — opinionated, occasionally useful, and frequently untrustworthy.

If you're here to find a polished, well-documented configuration set: look elsewhere. If you're here for a peek into how one developer configures their environment, a laugh at questionable choices, or to steal one-liners that may or may not break your shell, you're in the right place.

Quick stats
- Stability: Experimental. Use at your own peril. Backups are recommended.
- Support: None. Submit PRs if you dare.

What's in this repo
- Poorly written stuff that will probably break your system.

Why this repo exists
- Because committing a weird one-liner feels like a win
- Also, because version control looks good on résumés

Installation (TL;DR)
1. Clone it:
   git clone https://github.com/dhawk1981/dotfiles.git
2. Inspect everything. Seriously. Read the files.
3. Symlink or copy the bits you want into your home directory, for example:
   ln -s /path/to/dotfiles/shell/.bashrc ~/.bashrc
4. Restart your shell. If things explode, revert and blame the internet.

Recommended precautions
- Don't blindly run install scripts or `curl | sh` style commands from anyone — including me.
- Read, understand, and make backups. Use git to revert if you regret it.
- Use a throwaway VM if you want to experiment safely.

License
This is my personal configuration. Use at your own discretion. If you steal something useful, give me credit and maybe a joke in the PR.

Thanks for stopping by!
- dhawk1981

P.S. If this repo ever becomes a production-grade dotfiles collection, it will be because I got bored and organized everything — not because I planned it that way.