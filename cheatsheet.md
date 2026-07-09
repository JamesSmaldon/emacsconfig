# Cheat Sheet

## General 

| Key Combination | Description                                |
|-----------------|--------------------------------------------|
| SPC h C         | Open this cheat sheet                      |
| SPC h r r       | Reload doom config                         |
| SPC ,           | switch buffer within current workspace     |
| SPC <           | Switch to any buffer                       |
| SPC f p         | Find private files (config)                |
| SPC b D         | Pick buffer and kill from list             |
| SPC b d         | Kill current buffer                        |
| SPC b b         | Show list of buffers and select to open.   |
| SPC o p         | Open project tree view                     |
| SPC p p         | Open Project                               |
| SPC t w         | Wrap text (visually)                       |
| SPC s r         | Search and replace                         |
| SPC f d         | Find directory and open in dired           |
| SPC ~           | Restore last popup                         |
| M /             | Complete word                              |
| SPC p i         | invalidate project cache (refresh project) |

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

| Key Combination                       | Description                                  |
|---------------------------------------|----------------------------------------------|
| SPC g g                               | Open magit status                            |
| --> f                                 | fetch                                        |
| --> F                                 | Pull                                         |
| --> p                                 | Push                                         |
| --> diff view --> O f                 | Reset file to another version                |
| --> (on change) x                     | Discard                                      |
| SPC g d                               | diff current file against HEAD               |
| Shft Tab                              | Collapse all diffs                           |
| C RET (when hovering on a filename)   | Visit file for editing                       |
| SPC g B                               | Git blame                                    |
| SPC r e                               | Rebase onto another branch                   |
| SPC g t                               | Git time machine                             |
| --> (enter insert mode) p             | Previous change                              |
| --> (enter insert mode) n             | Next change                                  |
| C-c C-c (when editing commit message) | Finish commit (Don't do :q it doesn't work.) |

## Navigating Code

| Key Combination           | Description                     |
|---------------------------|---------------------------------|
| SPC c d                   | Goto definition                 |
| SPC c D                   | Find references                 |
| Ctrl-o                    | Navigate back                   |
| Ctrl-i                    | Navigate forward                |
| K or SPC c k              | Show hover docs                 |
| SPC c x                   | show list of all LSP issues     |
| zM                        | Fold all functions              |
| za                        | Toggle fold                     |
| SPC c i                   | Find implementation of function |
| SPC t m                   | Show minimap                    |
| SPC p c (C for recompile) | Compile code                    |
| M-g n/p                   | Navigate to next/previous error |
| SPC s p                   | Search project for string       |
| SPC s d/D       	    | Search directory                |
| --> M-p                   | Previous search                 |


## Editing Code
| Key Combination       | Description               |
|-----------------------|---------------------------|
| g c (with selection)  | Comment selected code     |
| M-x revert-buffer     | Reload file from disk     |
| SPC g B (q to remove) | Show git blame annotation |
| SPC c r               | Rename symbol   |
| gcc (gc on selection) | Toggle comments |

## Editing Markdown
| Key Combination | Description                    |
|-----------------|--------------------------------|
| SPC m p         | Preview markdown (using grip)  |

## Bookmarks
| Key Combination | Description        |
|-----------------|--------------------|
| SPC b m         | Set bookmark       |
| SPC RET         | Jump to bookmark   |
| SPC b L         | List all bookmarks |
| SPC b M         | Delete a bookmark  |

## Debugging

| Key Combination    | Description         |
|--------------------|---------------------|
| dap-debug          | Start debug session |
| dap-breakpoint-add | Add a breakpoint.   |

## Testing

| Key Combination | Description                      |
|-----------------|----------------------------------|
| SPC m t F       | Run pytest tests in current file |
| SPC m t t       | Run pytest test under cursor     |
| SPC p T         | Run tests for the entire project |

## Org Mode

| Key Combination        | Description           |
|------------------------|-----------------------|
| SPC o A                | Org mode agenda menu  |
| S-<left>/<right>       | Change status of task |
| C-c C-s (on todo item) | Schedule item         |
| C-c C-d (on todo item) | Set deadline          |
| C-c .                  | Stamp date on entry   |
| C-c C-z (on todo item) | Create Note on item   |
