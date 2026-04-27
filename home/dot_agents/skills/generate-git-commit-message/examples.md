# Examples

## Commit message with description and breaking change footer

```text
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

## Commit message with `!` to draw attention to breaking change

```text
feat!: send an email to the customer when a product is shipped
```

## Commit message with scope and `!` to draw attention to breaking change

```text
feat(api)!: send an email to the customer when a product is shipped
```

## Commit message with both `!` and BREAKING CHANGE footer

```text
feat!: drop support for Node 6

BREAKING CHANGE: use JavaScript features not available in Node 6.
```

## Commit message with no body

```text
docs: correct spelling of CHANGELOG
```

## Commit message with scope

```text
feat(lang): add Polish language
```

## Commit message with multi-paragraph body and multiple footers

```text
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from latest request.

Remove timeouts which were used to mitigate the racing issue but are
obsolete now.

Reviewed-by: Z
Refs: #123
```

## Commit message for a revert with `Refs:` footer

```text
revert: let us never again speak of the noodle incident

Refs: 676104e, a215868
```

## Commit message for a version bump

```text
chore: bump version to 1.0.0
```
