# text-tools

Small text transformations for Vim: turn Python dicts and JSON strings into
sorted JSON, number fold markers, and strip trailing whitespace and `\r` line
endings, on every write by default.

**Vim or Neovim:** tested on Vim 9.1 and newer. It's plain Vimscript, so it may
work on Neovim, but that's untested.

## Install

The two `Normalize` commands need `python3`.

```vim
Plug 'vimoured/text-tools'
```

## Use

| Command | What it does |
| --- | --- |
| `:[range]NormalizePythonDict` | Python literal (`{'a': True}`) to sorted, indented JSON. Defaults to the whole buffer. |
| `:[range]NormalizeJsonString` | Quoted JSON string (`'{"a": true}'`) to sorted, indented JSON. Defaults to the whole buffer. |
| `:NumberFoldMarkers` | Number every `{{{` as `{{{ (1/3)`, `{{{ (2/3)`, …; run again to renumber. |
| `:StripFoldMarkerNumbers` | Remove those numbers. |
| `:StripTrailingWhitespace` | Remove spaces and tabs at the end of each line. |
| `:StripTrailingCR` | Remove `\r` line endings. |

Every write strips `\r` endings and trailing whitespace. To change that:

| Variable | Set to `0` to |
| --- | --- |
| `g:text_tools_strip_on_save` | Stop stripping on save everywhere. |
| `b:text_tools_strip_on_save` | Save one buffer exactly as it is. |
| `b:text_tools_strip_whitespace` | Keep trailing whitespace in one buffer; `\r` endings are still stripped. |

## Tests

The specs in [vim-suite](https://github.com/vimoured/vim-suite) define what it
does: `test/text-tools.vim`.
