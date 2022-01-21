1. Add variable to expression:  
``` sed '1,'$N'd' $FILE ```
2. Take lines from a file from the range N1 to N2:  
``` sed -n ''$N1','$N2'p;'$N2'q' $FILE ```
