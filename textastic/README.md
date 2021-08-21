# Textastic for Atlas

## CodeCompletions

The file [asciidoc.json](asciidoc.json) contains a CodeCompletion file for Textastic.

### Groups

The completions are grouped by prefixes:

* +header+
* +content+
* +box+
* +list+
* +code+
* +format+
* +block+

The completions are also available under shorter names, for easier use.

### TextMate Bundle

Only provides the grammar, which is a copy of [https://github.com/zuckschwerdt/asciidoc.tmbundle](zuckschwerdt/asciidoc.tmbundle), but with the `scopeName` changed to `text.asciidoc`.