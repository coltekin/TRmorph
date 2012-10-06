BEGIN {line=""} 
{
    while (/^\t/) {
        line = (line  $0);
        getline;
   }
   if (line ~ /\*/) {
        gsub(/\*...:\t/, "", line);
        line = gensub(/[[:graph:]]+ +\[:+ *([^\]]+) *\]/, " \\1 ", "g", line);
        gsub(/[^\]]+\]/, "", line);
        gsub(/[\t ][\t ]*/, "\n", line);
        gsub(/[()]/, "", line);
        print line
   }
   line="";
   line = $0;
}
