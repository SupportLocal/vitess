#!/bin/bash

# Copyright 2012, Google Inc. All rights reserved.
# Use of this source code is governed by a BSD-style license that can
# be found in the LICENSE file.

if [ ! -f bootstrap.sh ]; then
  echo "bootstrap.sh must be run from its current directory" 1>&2
  exit 1
fi

. ./dev.env

mkdir -p $VTROOT/lib

# generate pkg-config, so go can use mysql C client
if [ ! -x $VT_MYSQL_ROOT/bin/mysql_config ]; then
  echo "cannot execute $VT_MYSQL_ROOT/bin/mysql_config, exiting" 1>&2
  exit 1
fi

cp $VTTOP/config/gomysql.pc.tmpl $VTROOT/lib/gomysql.pc
echo "Version:" "$($VT_MYSQL_ROOT/bin/mysql_config --version)" >> $VTROOT/lib/gomysql.pc
echo "Cflags:" "$($VT_MYSQL_ROOT/bin/mysql_config --cflags) -ggdb -fPIC" >> $VTROOT/lib/gomysql.pc
echo "Libs:" "$($VT_MYSQL_ROOT/bin/mysql_config --libs_r)" >> $VTROOT/lib/gomysql.pc
