BEGIN {line="";lineN=0} 
{
    while (/^\t/) {
        line = (line  $0);
        getline;
   }
   if (line ~ /^\*/) {
        l = "{" lineN "} "
        gsub(/\*...:\t/, l, line); # replace the prefix with the line number
#        gsub(/\*...:\t/, "", line); # delete the prefix
        # insert space before these:
        line = gensub(/([^ \t\[\]])([-+‘”"/*?!;.,]+)/, "\\1 \\2", "g", line);
        # insert space after these:
        line = gensub(/([-+/“‘"*?!;.,]+)([^ \t\[\]])/, "\\2 \\1 ", "g", line);
        # replace the alternative spelling with the correct one inside [: ...]
        line = gensub(/<[^>]+> +\[:+ *([^\]]+) *\]/, " \\1 ", "g", line);
        line = gensub(/[[:graph:]]+ +\[:+ *([^\]]+) *\]/, " \\1 ", "g", line);
        gsub(/[^\]]+\]/, "", line);
        gsub(/[\t ][\t ]*/, "\n", line);
        gsub(/[()<>:]/, "", line);
        if (line) {print line};
   }
   line = $0;
   lineN = lineN + 1
}
