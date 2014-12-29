#!/bin/bash

set -x 

#
# Open hbase shell and run the following to create 'user' table with 200 regions as per HBASE-4163
#
# create 'usertable', {NAME => 'family', COMPRESSION => 'snappy'}, {SPLITS => (1..200).map {|i| "user#{1000+i*(9999-1000)/200}"}, MAX_FILESIZE => 4*1024**3}
#
# To drop table,
#
# echo "disable 'user_table'" | hbase shell -n
# echo "drop 'user_table'" | hbase shell -n
#
java -Xmx4G -cp ycsb2-0.2-jar-with-dependencies.jar:/opt/cloudera/parcels/CDH/lib/hbase/*:/opt/cloudera/parcels/CDH/lib/hbase/lib/htrace-core.jar:/opt/cloudera/parcels/CDH/lib/hadoop/client/*:/etc/hbase/conf com.yahoo.ycsb.Client -load -db com.yahoo.ycsb.db.HBaseClient -p columnfamily=family -P custom_workload -p recordcount=250000000 -threads 10 -s
