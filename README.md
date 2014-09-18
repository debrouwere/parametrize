# Parametrize

When experimenting with data analysis techniques, it's often useful to run the same code but with a range of parameters to see what works and what doesn't. `parametrize` provides an intuitive way to execute a shell command multiple times using all possible permutations of a set of parameters.

Running this...

```shell
parametrize mycommand --slow -f go -d {1..3}x -f {1,5}
```

... will calculate the cartesian product of the specified parameters, and execute these commands:

```shell
mycommand --slow -f go -d 1x -f 1
mycommand --slow -f go -d 2x -f 1
mycommand --slow -f go -d 3x -f 1
mycommand --slow -f go -d 1x -f 5
mycommand --slow -f go -d 2x -f 5
mycommand --slow -f go -d 3x -f 5
```

## Installation and setup

Installation:

```shell
sudo wget https://raw.githubusercontent.com/stdbrouw/parametrize/master/parametrize -O /usr/local/bin/parametrize;
sudo chmod +x /usr/local/bin/parametrize;
```

You will need a working Python installation. Most Linux distributions as well as OS X provide this out of the box.

In bash, use like so:

```shell
(unsetopt braceexpand && parametrize mycommand ...)
```

In ZSH, use like so:

```
(setopt ignorebraces && parametrize mycommand ...)
```

Or put the following in your `~/.zshrc` or `~/.bashrc` and just put `parametrize` in front of your command, as in the first example.

```shell
alias parametrize='unsetopt braceexpand && setopt ignorebraces && _parametrize_'
_parametrize_() {
    /usr/bin/env parametrize $@;
    local rc=$?;
    setopt braceexpand;
    unsetopt ignorebraces;
    return $rc;
}
```

(Thanks to Bart Schaefer for the idea. If only there were a `nobraces` function
to go with `noglob`.)

For use with [GNU Make](https://www.gnu.org/software/make/), put this at the top of your Makefile:

```shell
.SHELLFLAGS := +B -c
```

These are a couple of small hurdles to go through, but after that you should be set.
