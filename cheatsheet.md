# Cheat Sheet

## General 

| Key Combination | Description                              |
|-----------------|------------------------------------------|
| SPC h C         | Open this cheat sheet                    |
| SPC h r r       | Reload doom config                       |
| SPC ,           | switch buffer                            |
| SPC f p         | Find private files (config)              |
| SPC b D         | Pick buffer and kill from list           |
| SPC b d         | Kill current buffer                      |
| SPC b b         | Show list of buffers and select to open. |
| SPC o p         | Open project tree view                   |
| SPC p p         | Open Project                             |
| SPC t w         | Wrap text (visually)                     |
| SPC s r         | Search and replace                       |
| SPC f d         | Find directory and open in dired         |
| SPC ~           | Restore last popup                       |
| M /             | Complete word                            |

## Search and replace across a project
SPC s p - search project, this gives list of results.
C-c C-e - Turn results into a buffer
C-c C-p - Make buffer editable.
:%s/old/new/g - Replace
C-c C-c - Commit changes to all files.

## Terminals

| Key Combination | Description                                |
|-----------------|--------------------------------------------|
| SPC o t         | Open vterm terminal (or toggle popup term) |

## Projects

| Key Combination | Description                          |
|-----------------|--------------------------------------|
| SPC p f         | Find file in project                 |
| SPC s p         | Search for text in project           |
| SPC s d         | Search for text in current directory |
| SPC p R         | Run project                          |

Change what gets run with SPC p R:

```
;; .dir-locals.el
((nil . ((projectile-project-run-cmd . "uv run main.py"))))
```

## Git

| Key Combination | Description                    |
|-----------------|--------------------------------|
| SPC g g         | Open magit status              |
| --> f           | fetch                          |
| --> F           | Pull                           |
| --> p           | Push
| SPC g d         | diff current file against HEAD |

## Navigating Code

| Key Combination | Description                     |
|-----------------|---------------------------------|
| SPC c d         | Goto definition                 |
| SPC c D         | Find references                 |
| Ctrl-o          | Navigate back                   |
| Ctrl-i          | Navigate forward                |
| K or SPC c k    | Show hover docs                 |
| SPC c x         | show list of all LSP issues     |
| zM              | Fold all functions              |
| za              | Toggle fold                     |
| SPC c i         | Find implementation of function |
| SPC t m         | Show minimap                    |

## Editing Code
| Key Combination       | Description               |
|-----------------------|---------------------------|
| g c (with selection)  | Comment selected code     |
| M-x revert-buffer     | Reload file from disk     |
| SPC g B (q to remove) | Show git blame annotation |
| SPC c r               | Rename symbol   |
| gcc (gc on selection) | Toggle comments |


## Debugging

| Key Combination | Description       |
|-----------------|-------------------|
| F9              | Toggle breakpoint |
| F5              | Start debugging   |
| F6              | Next              |
| F7              | Step In           |
| F8              | Step Out          |

## Testing

| Key Combination | Description                      |
|-----------------|----------------------------------|
| SPC m t F       | Run pytest tests in current file |
| SPC m t t       | Run pytest test under cursor     |
| SPC p T         | Run tests for the entire project |
