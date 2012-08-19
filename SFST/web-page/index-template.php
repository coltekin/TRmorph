<html>
<head>
   <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
   <title>TRmorph: A free morphological analyzer for Turkish</title>
   <link type="text/css" rel="stylesheet" href="http://www.let.rug.nl/coltekin/cc.css">
   <meta name="keywords" content="morphology, turkish, turkish morphology, morphological analyzer, two-level analyzer"/>
</head>
<script language="javascript">
function addCh(ch)
{
    document.getElementById('inputbox').value += ch
    document.inputform.inputbox.focus();
}
</script>
<body onLoad="document.inputform.inputbox.focus();">
<p>


<center><h1>TRmorph: A Turkish morphological analyzer</h1></center>

<p>
<div class=xx>

<p> TRmorph is a relatively complete morphological analyzer for
Turkish. It is implemented using <a
href="http://www.ims.uni-stuttgart.de/projekte/gramotron/SOFTWARE/SFST.html">
SFST</a>, and uses a lexicon based on (but heavily modified) the
word list from <a href=http://code.google.com/p/zemberek/>Zemberek</a>
spell checker. The morphological analyzer is distributed under
the <a href=http://www.gnu.org/licenses/gpl.html>GPL</a>.

<p> Latest tested version can be downloaded <a
href="trmorph-0.2.1.tar.gz">here</a>.  As well as the full source
code, a compiled fsa, suitable to be used with SFST tools, is included
in this package. The latest development version can be downloaded from
<a href="https://github.com/coltekin/TRmorph">github</a>.  To use the
analyzer you need <a
href="http://www.ims.uni-stuttgart.de/projekte/gramotron/SOFTWARE/SFST.html">SFST</a>.
The analyzer can also be compiled and used with <a
href=http://www.ling.helsinki.fi/kieliteknologia/tutkimus/hfst/>HFST</a>
tools. A UNIX makefile is provided for easy compilation from the
sources (see the included <a href=README><tt>README</tt></a> file for
details. 

<p>The analyzer is fairly complete, however, it may not be easy on
unaccustomed eyes. Documentation and cleanup work is going on, you may
want to visit soon to get a newer version. I'm always interested in
comments, corrections or improvements from others. Please feel free to
contact <a href=http://www.let.rug.nl/coltekin/>me</a>.

<p>If you use this analyzer in your research, and want to cite it,
please cite the following paper:

<p>Çağrı Çöltekin (2010). 
  <i>A Freely Available Morphological Analyzer for Turkish </i>
  In Proceedings of the 7th International Conference on
  Language Resources and Evaluation (LREC2010), Valletta, Malta, 
  May 2010.  (<a href=../papers/coltekin-lrec2010.pdf>pdf</a>).
  <br>

</div>

<p> <center><a name="demo"><h2>TRmorph Demo</h2></a></center>

<p>
<div class=xx>
<p> You can try the current development version (as of __DATE__) of
    TRmorph here. If you have javascript enabled
    you can use the buttons below the input box to enter special
    Turkish characters. The analysis symbols are linked to their
    descriptions in this page. The stems are linked to their <a
    href="http://www.wiktionary.org/">Wiktionary</a> definitions.

<p> Some characters in the input string are filtered out in the web
demo.  If the demo fails to accept the input you provide, or if you
need to analyze large amount of data, please download and use an
off-line version.

<p> If things do not looks as they should, please let
<a href=http://www.let.rug.nl/coltekin/>me</a> know.

<p>
<table width="95%">
<tr>
<td width="40%" valign="top">
<form name="inputform" method='post' action='__URL__'>
Type the word to analyze:<br>
<input type="text" name="word" id="inputbox">
<input type='submit' value='Analyze' name='submit'><br>
<input type="button" value="ç" onclick=addCh("ç")>
<input type="button" value="ğ" onclick=addCh("ğ")>
<input type="button" value="ı" onclick=addCh("ı")>
<input type="button" value="ö" onclick=addCh("ö")>
<input type="button" value="ş" onclick=addCh("ş")>
<input type="button" value="ü" onclick=addCh("ü")>
</form>
</td>
<td valign="top">

<?php
setlocale(LC_CTYPE, "en_US.UTF-8");
/*
    foreach ( $_POST as $key => $value ) { 
        echo $key . " " . "=" . " " . $value; 
        echo  "<BR>"; 
    }
*/

    if (isset($_POST["submit"])) {
        $word = $_POST["word"];
//        $word = preg_replace("/[^a-zçğıöşü0-9' -]/", "", $word);
        $word = escapeshellarg($word);
        
        echo "Analysis for the word <b>$word</b>:<br><br>";
        $command = "echo $word | __WEBDIR__/fst-infl -q trmorph.a";
        exec($command, $output); 
        echo "<ul>";
        foreach($output as $line){
            if (preg_match("/^>/i", $line)) {
                continue;
            }
    
            $dicturl = 'http://tr.wiktionary.org/wiki/';
            $stem = preg_replace("/^([^<]+)<.*/", "$1", $line);
            $pos = preg_replace("/^[^<]+<([^>]+)>.*/", "$1", $line);

            if (strcmp($pos, "v") == 0) { // verb 
                if (preg_match("/.*[aıou][^eiöü]*$/", $stem)) {
                    $dictq =  $dicturl . $stem . 'mak';
                } else {
                    $dictq = $dicturl . $stem . 'mek';
                }
            } else {
                $dictq = $dicturl . $stem ;
            }
            $line = preg_replace("/<([^>]+)>/", 
                                 "&lt;<a href=\"#$1\">$1</a>&gt;", $line);
            $line = preg_replace("/^[^&]+(&lt;.*)/",
                                 "<a href=\"$dictq\">$stem</a>$1",
                                 $line);
            printf("<li>%s<br>\n", $line);
        }
        echo "</ul>";
    }

?>
</td>
</tr>
</table>
</div>


<p> <center><h2>TRmorph Analysis Symbols</h2></center>


<p>
<div class=xx>
<p> The following is a (partial) list of analysis symbols used in
    TRmorph. The documentation below does not yet include the 
    derivational morphemes that start with D_.

<p>
<table class="tlt" width="95%">
<tr><th>Symbol
    <th>Gloss
    <th>Notes/Example

<?php
include 'sym-table.html';
?>

</table>


</div>

<?php
    error_reporting(0);
    if (isset($_POST["submit"])) {
        $word = $_POST["word"];
    } else  {
        $word = "";
    }

    $fp = fopen(".log", "a");
    foreach ($_SERVER as $key => $value) {
        fprintf($fp, "%s=%s\t", $key, $value); 
    }
    fprintf($fp, "\n"); 

    fprintf($fp, "time,remote,forwarded_for,word:%s|%s|%s|%s\n",
            $_SERVER["REQUEST_TIME"],
            $_SERVER["REMOTE_ADDR"],
            $_SERVER["HTTP_X_FORWARDED_FOR"],
            $word);
    fclose($fp);
?>
<p class="date">Last updated: __DATE__</p>

</body>
</html>
