
grep processing log.txt | awk '{ print $5 }' | sort | wc -l
grep processing log.txt | awk '{ print $5 }' | sort | uniq | wc -l

