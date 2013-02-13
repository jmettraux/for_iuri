
# for_iuri

Chasing the issue in https://groups.google.com/forum/?fromgroups#!topic/openwferu-users/rd0pnazNxu4


## usage

Assumes you

at first run

    bundle exec ruby iuri.rb purge

to clean the ruote_test db.

Then, in three different terminals, run

    bundle exec ruby iuri.rb worker

Then, in a different terminal, run

    bundle exec ruby iuri.rb launch

Observe the work circulating from one worker to the other.


## tested (jmettraux) with

Ruby 1.9.3-p324 and

```
$ bundle list
Gems included by the bundle:
  * blankslate (2.1.2.4)
  * bundler (1.2.3)
  * file-tail (1.0.12)
  * mysql2 (0.3.11)
  * parslet (1.4.0)
  * ruby2ruby (1.3.1)
  * ruby_parser (2.3.1)
  * rufus-cloche (1.0.2)
  * rufus-dollar (1.0.4)
  * rufus-json (1.0.2)
  * rufus-mnemo (1.2.3)
  * rufus-scheduler (2.0.17)
  * rufus-treechecker (1.0.8)
  * ruote (2.3.0.2)
  * ruote-sequel (2.3.0)
  * sequel (3.44.0)
  * sexp_processor (3.2.0)
  * sourcify (0.5.0)
  * tins (0.6.0)
  * tzinfo (0.3.35)
  * yajl-ruby (1.1.0)
```

and

```
$ mysql --version
mysql  Ver 14.14 Distrib 5.1.49, for apple-darwin10.4.0 (i386) using readline 6.1
```

## license

This mini issue-solving project is released under the MIT license.

