1. Find a number of line by the regular expression:
``` bash
awk '/<regular expression>/{ print NR; exit }'
```
2. Get lines from FILE after defined number of line(N1):
``` bash
cat $FILE | awk -v var="$N1" 'NR > var'
```
