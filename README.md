# text-tools

Small text transformations.

| Command | What it does |
| --- | --- |
| `:[range]NormalizePythonDict` | Python literal (`{'a': True, 'b': None}`) → sorted, indented JSON. Needs `python3`. |
| `:[range]NormalizeJsonString` | Quoted JSON string (`'{"a": true}'`) → sorted, indented JSON. Needs `python3`. |
| `:NumberFoldMarkers` | Number every `{{{` as `{{{ (1/3)`, `{{{ (2/3)`, … for easy navigation. |
| `:StripFoldMarkerNumbers` | Remove those numbers again. |
| `:StripTrailingWhitespace` | Remove trailing spaces and tabs (lines with only whitespace are left alone). |
| `:StripTrailingCR` | Remove `\r` line endings. |

Both `Normalize` commands default to the whole buffer.

## Options

| Variable | Default | |
| --- | --- | --- |
| `g:text_tools_strip_on_save` | `0` | Strip `\r` endings and trailing whitespace before every write. |
| `b:text_tools_strip_whitespace` | `1` | Set to `0` to keep trailing whitespace in one buffer. |

## Install

```vim
Plug 'roumail/text-tools'
```
