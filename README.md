# CSearch

CSearch is a simple vim utlilty to search for matching c-like patterns. The
lexing is crude and should not be completely trusted. That said, it works in
most common cases and allows for matching different coding styles as shown
bellow.

## Usage
CSearch provides visual mode mapping (default `//`).

## Examples
CSearch matches different coding styles across multiple lines:
```
template<typename T>
foo(T* a) {


template < typename T > foo ( T *a )
{
```

CSearch also is agnostic to macro continuations lines
```
#define FOO(A,B)  \
BAR(A,B)

#define FOO(A,B) BAR(A,B)
```

## Default Mapping
The default visual mode mapping is `//` and can be changed with
`g:CSearch_v_map = '//'`
