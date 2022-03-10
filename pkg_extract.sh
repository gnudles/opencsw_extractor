#!/bin/sh
# We ungzip the gz file
# We skip the first 512 bytes of package datastream header, and then we get a normal svr4 archive for cpio. almost normal.
# We replace the *first* early terminator of "TRAILER!!!", in order to bypass this strange hack. otherwise, we will only get the first two files.
# We hope that the pattern we match here, is very unique, otherwise we screw things up inside file content. The alternative is to create cpio fork, that ignores that strange TRAILER.
# We let cpio do the rest...
gzip -cdk $1 | tail -c +513 |sed  '0,/0000TRAILER!!!\x0\x0\x0\x0/s/0000TRAILER!!!\x0\x0\x0\x0/0000SPOILER!!!\x0\x0\x0\x0/g' | cpio -idu -0 -v -H newc --no-absolute-filenames
