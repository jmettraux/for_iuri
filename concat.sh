
cat dlog_* | sort > log.txt
rm dlog*

grep processing log.txt | awk '{ print $5 }' | sort | wc -l
grep processing log.txt | awk '{ print $5 }' | sort | uniq | wc -l

