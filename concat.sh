
cat dlog_* sequel_*.log | sort > log.txt
rm dlog* sequel_*.log

grep processing log.txt | awk '{ print $5 }' | sort | wc -l
grep processing log.txt | awk '{ print $5 }' | sort | uniq | wc -l

