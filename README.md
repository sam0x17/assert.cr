# assert.cr

assert.cr provides a simple C++-style `assert!` macro you can use anywhere in your crystal code. if
the expression passed to `assert!` [roughly evaluates to true](https://github.com/sam0x17/assert.cr/blob/master/src/assert.cr#L12)
at runtime, then nothing will happen and your code will proceed on normally. If the
expression evaluates to false (e.g. `assert! false`, `assert! 2 + 1 == 4` or `assert! 0`),
then an exception will be raised giving you a stack trace of the failed assertion as
well as a message repeating the expression that failed.

If you build your app/library with the `--release` compile-time flag (which you should
always use for production builds), assertions will not be compiled so there will be
_zero_ performance hit for using this library.

## New: Release Assertions

Assertions that run even when compiled with the `--release` flag are now supported via
the `assert` (no exclamation point) macro. This can be thought of as a simple shorthand
for raising an error if `expr` is false, but is useful in a variety of circumstances.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  assert:
    github: sam0x17/assert.cr
```

## Example

This is a simple assertion that will fail if it gets to execute since `5 - 5 = 0` and `0` is `false`:
```crystal
# example.cr
require "assert"

assert! 5 - 5
puts "made it past the assertion"
```

Runtime result without --release flag:
```bash
$ crystal run src/example.cr
Unhandled exception: assertion "5 - 5" failed (Exception)
  from src/assert.cr:0:1 in '__crystal_main'
  from /usr/share/crystal/src/crystal/main.cr:104:5 in 'main_user_code'
  from /usr/share/crystal/src/crystal/main.cr:93:7 in 'main'
  from /usr/share/crystal/src/crystal/main.cr:133:3 in 'main'
  from __libc_start_main
  from _start
  from ???
```

Runtime result with --release flag:
```bash
$ crystal run src/example.cr --release
made it past the assertion
```
