# CSearch

CSearch is a simple vim function and mapping to allow for ignoring whitespace
while searching in a c-like fashion. Most declarations can be matched regardless
of format and line splitting. Macro continuation lines are also ignored.

## Default Mapping
The default visual mode mapping is `//` and can be changed with
`g:CSearch_v_map = '//'`
