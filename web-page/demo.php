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
wordlist of <a href=http://code.google.com/p/zemberek/>Zemberek</a>
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

<p>Soon, more information about the analyzer, and a web-based demo
will be provided.

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
<p> You can try current version of TRmoprh by typing the word in the box 
    and click 'Analyze' button. If you have javascript enebled you can use the
    buttons below the inputbox to enter special Turkish characters.
    If things do not looka as it should, please let me know.
<p> For this demo, anything except <b>lowercase</b> letters, digits,
    dash (-) and and apostrophe (') is filtered out. If you need
    analysis involving other symbols, or need to analyze large amount
    of data, please download and use an the off-line version.
<p>
<table width="95%">
<tr>
<td width="40%" valign="top">
<form name="inputform" method='post' action='http://www.let.rug.nl/coltekin/trmorph/demo/index'>
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
    trmorph.


<p>
<table class="tlt" width="95%">
<tr><th>Symbol
    <th>Gloss
    <th>Notes/Example

<tr><th colspan=3 class=th2>
     POS tags
<tr><td><a name="adj"><b>adj</b>
    <td><a href=http://en.wikipedia.org/wiki/Adjective>Adjective</a>
    <td>&nbsp;
<tr><td><a name="adv"><b>adv</b>
    <td><a href=http://en.wikipedia.org/wiki/Adverb>Adverb</a>
    <td>&nbsp;
<tr><td><a name="n"><b>n</b>
    <td><a href=http://en.wikipedia.org/wiki/Noun>Noun</a>
    <td>&nbsp;
<tr><td><a name="np"><b>np</b>
    <td><a href=http://en.wikipedia.org/wiki/Proper_name>Proper name</a>
    <td>&nbsp;
<tr><td><a name="prn"><b>prn</b>
    <td><a href=http://en.wikipedia.org/wiki/Pronoun>Pronoun</a>
    <td>&nbsp;
<tr><td><a name="postp"><b>postp</b>
    <td><a href=http://en.wikipedia.org/wiki/Postposition>Postposition</a>
    <td>&nbsp;
<tr><td><a name="iy"><b>iy</b>
    <td><a href=http://en.wikipedia.org/wiki/Interjection>Interjection</a>
    <td>&nbsp;
<tr><td><a name="cnj"><b>cnj</b>
    <td><a href=http://en.wikipedia.org/wiki/Grammatical_conjunction>Conjunction</a>
    <td>&nbsp;
<tr><td><a name="v"><b>v</b>
    <td><a href=http://en.wikipedia.org/wiki/Verb>Verb</a>
    <td>&nbsp;
<tr><td><a name="vaux"><b>vaux</b>
    <td><a href=http://en.wikipedia.org/wiki/Auxiliary_verb>Auxiliary</a>
    <td>&nbsp;
<tr><td><a name="num"><b>num</b>
    <td><a href=http://en.wikipedia.org/wiki/Number>Number</a>
    <td>&nbsp;
<tr><td><a name="pnct"><b>pnct</b>
    <td><a href=http://en.wikipedia.org/wiki/Punctuation>Punctuation</a>
    <td>&nbsp;
<tr><th colspan=3 class=th2>
     Nominal morphemes
<tr><th colspan=3 class=th3>
    <a href=http://en.wikipedia.org/wiki/Plural> Plural suffix</a>
<tr><td><a name="pl"><b>pl</b>
    <td>Plural suffix            
    <td> ev-ler    `houses'
<tr><th colspan=3 class=th3>
    <a href=http://en.wikipedia.org/wiki/Possessive_suffix> Possessive suffixes</a>
<tr><td><a name="p1s"><b>p1s</b>
    <td>1st person singular possessive    
    <td> ev-im `my house'
<tr><td><a name="p2s"><b>p2s</b>
    <td>2nd person singular possessive    
    <td> ev-in `your house'
<tr><td><a name="p3s"><b>p3s</b>
    <td>3rd person singular possessive    
    <td> ev-i `his/her/its house'
<tr><td><a name="p1p"><b>p1p</b>
    <td>1st person plural possessive  
    <td> ev-imiz `our house'
<tr><td><a name="p2p"><b>p2p</b>
    <td>2st person plural possessive  
    <td> ev-iniz `your(plural/formal) house'
<tr><td><a name="p3p"><b>p3p</b>
    <td>3st person plural possessive  
    <td> ev-leri `their house'
<tr><th colspan=3 class=th3>
    <a href=http://en.wikipedia.org/wiki/Grammatical_case> Case suffixes (or postpositions)</a>
<tr><td><a name="loc"><b>loc</b>
    <td><a href=http://en.wikipedia.org/wiki/Locative_case   >Locative case</a>
    <td> ev-de `in/on/at the house'
<tr><td><a name="gen"><b>gen</b>
    <td><a href=http://en.wikipedia.org/wiki/Genitive_case  >Genitive case</a>
    <td> ev-in `the one that belongs the house'
<tr><td><a name="acc"><b>acc</b>
    <td><a href=http://en.wikipedia.org/wiki/Accusative_case   >Accusative case</a>
    <td> ev-i 
<tr><td><a name="abl"><b>abl</b>
    <td><a href=http://en.wikipedia.org/wiki/Ablative_case     >Ablative case</a>
    <td> ev-den   `from the house'
<tr><td><a name="dat"><b>dat</b>
    <td><a href=http://en.wikipedia.org/wiki/Dative_case      >Dative case</a>
    <td> ev-e    `to the house'
<tr><td><a name="ins"><b>ins</b>
    <td><a href=http://en.wikipedia.org/wiki/Instrumental_case >Instrumental/comitative</a>
    <td> ev-le  `with the house' (this one also hase a clitic equivalent `ile', and is not considered as a case for most grammar books)
<tr><th colspan=3 class=th3>
     ki
<tr><td><a name="ki"><b>ki</b>
    <td>
    <td> ev-de-ki-nin-ki  `the one that belongs to the person in the house' 
<tr><th colspan=3 class=th2>
     Morphemes that attach to (mostly) verbs
<tr><th colspan=3 class=th3>
     voice suffixes
<tr><td><a name="ref"><b>ref</b>
    <td>Reflexive   
    <td> yıka `to wash' -> yıka-n `to wash oneself'
<tr><td><a name="rec"><b>rec</b>
    <td>Reciprocal  
    <td> sev `to love' -> sev-iş `to love each other/make love'
<tr><td><a name="caus"><b>caus</b>
    <td>Causative, can be multiple 
    <td> yika-t-tır `to make someone have (something) washed'
<tr><td><a name="pass"><b>pass</b>
    <td>Passive 
    <td> sev-il `to be loved'
<tr><th colspan=3 class=th3>
     Compound verb morphemes
<tr><td><a name="abil"><b>abil</b>
    <td>ability 
    <td> gör-ebil `to be able to see'
<tr><td><a name="iver"><b>iver</b>
    <td>quickly 
    <td> yıka-yıver `wash it quickly'
<tr><td><a name="adur"><b>adur</b>
    <td>not very productive
    <td>&nbsp;
<tr><td><a name="agel"><b>agel</b>
    <td>not very productive
    <td>&nbsp;
<tr><td><a name="agor"><b>agor</b>
    <td> not very productive
    <td>&nbsp;
<tr><td><a name="akal"><b>akal</b>
    <td> not very productive
    <td>&nbsp;
<tr><td><a name="akoy"><b>akoy</b>
    <td> not very productive
    <td>&nbsp;
<tr><td><a name="ayaz"><b>ayaz</b>
    <td> not very productive
    <td>&nbsp;
<tr><th colspan=3 class=th3>
     negative marker(s)
<tr><td><a name="neg"><b>neg</b>
    <td>Negative 
    <td>&nbsp;
<tr><th colspan=3 class=th3>
     Tense/aspect/modality markers
<tr><td><a name="t_narr"><b>t_narr</b>
    <td>narrative past tense 
    <td> görmüş `it is evident/said that he/she/it saw (something)'
<tr><td><a name="t_past"><b>t_past</b>
    <td>past  
    <td> gördü `he/she/it saw (something)'
<tr><td><a name="t_fut"><b>t_fut</b>
    <td>future    
    <td> görecek `he/she/it will se (something)'
<tr><td><a name="t_cont"><b>t_cont</b>
    <td>continuous 
    <td> görüyor `he/she/it is seeing (something)'
<tr><td><a name="t_aor"><b>t_aor</b>
    <td>aorist    
    <td> görür    `he/she/it sees (something)'
<tr><td><a name="t_makta"><b>t_makta</b>
    <td>?
    <td>&nbsp;
<tr><td><a name="t_obl"><b>t_obl</b>
    <td>obligation    
    <td> görmeli `he/she/it must see (something)'
<tr><td><a name="t_opt"><b>t_opt</b>
    <td>optative
    <td>&nbsp;
<tr><td><a name="t_cond"><b>t_cond</b>
    <td>conditional
    <td>&nbsp;
<tr><th colspan=3 class=th3>
     Person agreement
<tr><td><a name="1s"><b>1s</b>
    <td>1st person singular 
    <td> gör-dü-m `I saw'
<tr><td><a name="2s"><b>2s</b>
    <td>2nd person singular 
    <td> gör-dü-n `you saw'
<tr><td><a name="3s"><b>3s</b>
    <td>3rd person singular 
    <td> gör-dü- `hi/she/it saw'
<tr><td><a name="1p"><b>1p</b>
    <td>1st person plural 
    <td> gör-dü-k `we saw'
<tr><td><a name="2p"><b>2p</b>
    <td>2st person plural 
    <td> gör-dü-nüz `you(plural/formal) saw'
<tr><td><a name="3p"><b>3p</b>
    <td>3st person plural 
    <td> ev-dü-ler `they saw'
<tr><th colspan=3 class=th3>
     Copular markers. 
<tr><td><a name="cpl_di"><b>cpl_di</b>
    <td>past copula  
    <td> 
<tr><td><a name="cpl_mis"><b>cpl_mis</b>
    <td>evidential copula 
    <td>&nbsp;
<tr><td><a name="cpl_sa"><b>cpl_sa</b>
    <td>conditional copula 
    <td>&nbsp;
<tr><td><a name="cpl_ken"><b>cpl_ken</b>
    <td>makes adverbs, but behaves like a copula 
    <td>&nbsp;
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
