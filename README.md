# text-tools

Small text transformations.

| Command | What it does |
| --- | --- |
| `:[range]NormalizePythonDict` | Python literal (`{'a': True, 'b': None}`) → sorted, indented JSON. Needs `python3`. |
| `:[range]NormalizeJsonString` | Quoted JSON string (`'{"a": true}'`) → sorted, indented JSON. Needs `python3`. |
| `:NumberFoldMarkers` | Number every `{{{` as `{{{ (1/3)`, `{{{ (2/3)`, … for easy navigation. Run again, it renumbers them (*not yet*: it adds a second number). |
| `:StripFoldMarkerNumbers` | Remove those numbers again. |
| `:StripTrailingWhitespace` | Remove the spaces and tabs after the last non-blank character of each line. The cursor stays where it is. |
| `:StripTrailingCR` | Remove `\r` line endings. |

Both `Normalize` commands default to the whole buffer. Text they can't read
stays as it is, with an error message (*not yet*: Python's traceback replaces
it). With no fold markers in the buffer, both fold marker commands leave it as
it is (*not yet*: they raise E486).

*Not yet* marks a known bug: [vim-suite](https://github.com/vimoured/vim-suite)
asserts the behaviour described (its `test/known-failures.txt`), and the note
goes once it's fixed.

## Options

Every write strips `\r` endings and trailing whitespace first (*not yet*: only
with `g:text_tools_strip_on_save` set to `1`; the default is off).

| Variable | Default | |
| --- | --- | --- |
| `g:text_tools_strip_on_save` | `1` | Set to `0` to stop stripping on save everywhere. |
| `b:text_tools_strip_on_save` | `1` | Set to `0` to save one buffer exactly as it is, nothing stripped (*not yet*: there's no such switch; `\r` endings are stripped regardless). |
| `b:text_tools_strip_whitespace` | `1` | Set to `0` to keep trailing whitespace in one buffer; `\r` endings are still stripped. |

## Install

```vim
Plug 'vimoured/text-tools'
```

## Tests

Tested by [vim-suite](https://github.com/vimoured/vim-suite), in
`test/text-tools.vim`, with the dotfiles that use it. Every pull request runs
it.
