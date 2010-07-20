<html>
<head>
   <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
   <title> TRmorph demo</title>
   <link type="text/css" rel="stylesheet" href="../../cc.css">
   <meta name="keywords" content="morphology, turkish, two-level analyzer"/>
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
Turkish.  It is implemented using <a
href="http://www.ims.uni-stuttgart.de/projekte/gramotron/SOFTWARE/SFST.html">
SFST</a>, and uses a lexicon based on (but heavily modified) the
word list from <a href=http://code.google.com/p/zemberek/>Zemberek</a>
spell checker. The morphological analyzer is distributed under
the <a href=http://www.gnu.org/licenses/gpl.html>GPL</a>.

<p> Latest  version can be downloaded <a
href="trmorph-0.2.tar.gz">here</a>. To use the analyzer you need <a
href="http://www.ims.uni-stuttgart.de/projekte/gramotron/SOFTWARE/SFST.html">SFST</a>.
As well as the full source code, a compiled fsa, suitable to be used
with SFST's fst-mor or fst-infl is included. A UNIX makefile is
provided for easy compilation from the sources (see the included
<tt>README</tt> file for details. The analyzer is fairly complete,
however, it may not be easy on unaccustomed eyes. Documentation and
cleanup work is going on, you may want to visit soon to get a newer
version.

<p>I'm always interested in comments, corrections or improvements from
others. Please feel free to contact <a
href=http://www.let.rug.nl/coltekin/>me</a>.

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
<p> You can try current version of TRmorph by typing the word in the box 
    and click 'Analyze' button. If you have javascript enabled you can use the
    buttons below the input box to enter special Turkish characters.
    If things do not looks as it should, please let me know.
<p> For this demo, anything except <b>lowercase</b> letters, digits,
    dash (-) and apostrophe (') is filtered out. If you need
    analysis involving other symbols, or need to analyze large amount
    of data, please download and use an off-line version.
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

/*
    foreach ( $_POST as $key => $value ) { 
        echo $key . " " . "=" . " " . $value; 
        echo  "<BR>"; 
    }
*/

    if (isset($_POST["submit"])) {
        $word = $_POST["word"];
        $word = preg_replace("/[^a-zçğıöşü0-9' -]/", "", $word);
        
        echo "Analysis for the word <b>$word</b>:<br><br>";
        $command = "echo \"$word\" | /storage/coltekin/public_html/trmorph/demo/fst-infl -q trmorph.a";
        exec($command, $output); 
        echo "<ul>";
        foreach($output as $line){
            if (preg_match("/^>/i", $line)) {
                continue;
            }
    
            $line = preg_replace("/<(\w+)>/", "&lt;<a href=\"#$1\">$1</a>&gt;", $line);
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
    TRmorph. The list below does not include the derivational
    morphemes that start with D_.

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
    $fp = fopen(".log", "a");
    foreach ($_SERVER as $key => $value) {
        fprintf($fp, "%s=%s\t", $key, $value); 
    }
    fprintf($fp, "\n"); 
    fclose($fp);
?>

</body>
</html>
