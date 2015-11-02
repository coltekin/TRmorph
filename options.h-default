/* 
 * This file lists some configurable options for building various
 * components of TRmoprh. The file is simply a C preprocessor file
 * with #define directives. The options and their use are specified
 * below. 
 *
 */

/* MARK_NCOMP   Use the <ncomp> tag to mark potential heads of nominal
 *              compounds.
 *              This tag creates a lot of ambiguity because it
 *              has the same form as the <p3s>, and it occupies the
 *              same slot as the possessive markers (it cannot coexist
 *              with any of them). If marking nominal compounds is
 *              important the tag may be useful. but it is disabled by
 *              default here since it doubles the number of analyses
 *              of any word with a -sI (and other possessive markers)
 */

#define MARK_NCOMP 0

/* 
 * APOSTROPHE_OPTIONAL      Relaxed apostrophe behavior after proper 
 *                          names and numbers.
 * APOSTROPHE_OPTIONAL_NUM  Only for numbers.
 * APOSTROPHE_OPTIONAL_PN   Only for proper names.
 * 
 * NOTE: currently,  TRmorph's apostrophe insertion does not fully
 * comply with the official spelling rules.
 */
#define APOSTROPHE_OPTIONAL 1
#define APOSTROPHE_OPTIONAL_NUM  APOSTROPHE_OPTIONAL
#define APOSTROPHE_OPTIONAL_PN   APOSTROPHE_OPTIONAL
#define APOSTROPHE_OPTIONAL_ABBR APOSTROPHE_OPTIONAL

/* 
 * NOUN_APOSTROPHE  Whether to allow an optional apostrophe after
 *                  common nouns. This allows analysis of
 *                  compounds forming proper names like 'Türkiye
 *                  Büyük Millet Meclisi', 'Ağrı Dağı' etc.
 *                  Ideally these names should be tokenized
 *                  together, but if not, this option will allow
 *                  last part of these compounds to be analyzed if
 *                  they have further suffixes (after an apostrophe)
 */
#define NOUN_APOSTROPHE 1


/* APOSTROPHE_SYMS
 *
 * The symbols that are accepted as apostrophe. This will increase
 * ambiguity in expressions involving apostrophe.
 */

#define APOSTROPHE_SYMS %'|%’|%´|%′|%ʼ

/*
 * CAPITALIZE: this allows first letter of  any word to be capital. This 
 *             is fits typical use case of an analyzer. One may want to 
 *             disable this for generation.
 * ALLCAPS:    Analyze and generate words that are in ALL CAPITAL LETTERS.
 *
 */

#define ALLCAPS 1
#define CAPITALIZE 1
#define GUESSER_ALLCAPS 1
#define GUESSER_CAPITALIZE 1

/*
 * SURFACE_CIRCUMFLEX: The vowels with circumflex î, û, â are written 
 *                     without circumflex most of the time. Setting this 
 *                     option to 1 accepts words whose surface form does 
 *                     have a circumflexed vowel despite it is defined 
 *                     in the lexicon with a circumflex.
 */
#define CIRCUMFLEX_OPTIONAL 1
#define GUESSER_CIRCUMFLEX_OPTIONAL 0

/* 
 *
 * RELAXED_C_ASSIMILATION: The underlying C at the beginning of some
 * of the suffixes such as -CI normally goes through voicing
 * assimilation, so the correct form is `c' after a voiced consonant
 * of a vowel `şeker-ci' and `ç' after non-voiced consonant
 * `şarap-çı'. However, people often seem to omit devoicing, e.g.,
 * say/write `şarap-cı'. Enabling this options allow analyzing these
 * words.
 *
 * This option is currently global. It cannot be customized for
 * different components here.
 *
 */
#define RELAXED_C_ASSIMILATION 0

/* 
 *
 * RELAXED_D_ASSIMILATION: Similar to RELAXED_C_ASSIMILATION, but this
 * is more rare, like  'görüşdükten'.
 */
#define RELAXED_D_ASSIMILATION 0

/* 
 * These options are only for guesser. The guesser will attempt to
 * guess the words whose length is in range GUESSER_MIN_LENGTH -
 * GUESSER_MAX_LENGTH.
 *
 * If GUESSER_STEM is set to 1, the result of the guesser will be the
 * stem(s), not full analyses.
 *
 */

#define GUESSER_MIN_LENGTH 2
#define GUESSER_MAX_LENGTH 10
#define GUESSER_STEM 0

/* 
 * These options are only for the stemmer. 
 *
 * Stemmer will normally output only the stem. 
 * Setting STEMMER_KEEP_ROOT_POS to 1 will cause stemmer to keep 
 * the POS tag of the root form. Note that this is not necessarily the
 * final syntactic function of the word.
 *
 * Setting STEMMER_LEMMATIZE to 1 will result in replacing verbs with
 * their dictionary citation form (infinitive) with additional -mek or
 * -mak suffix.
 *
 */
#define STEMMER_KEEP_ROOT_POS 1
#define STEMMER_LEMMATIZE 1

/* DECIMAL_SEPARATOR, THOUSAND_SEPARATOR 
 * 
 * These options allow arbitrary symbols to be assigned to decimal and
 * thousand separators. According to the official rules, comma `,' is
 * decimal separator, and `.' is the thousand separator. But this is
 * rarely followed in practice.
 */

/* #define DECIMAL_SEPARATOR "%,"
 * #define THOUSAND_SEPARATOR "%."
 */

#define DECIMAL_SEPARATOR %,|%.
#define THOUSAND_SEPARATOR %.|%,

/* MI_NOSPACE
 *
 * If this option is set to 1, the question particle -mI will be
 * allowed to be written together with the predicate it attaches to.
 * This is incorrect spelling, but a very common mistake in informal
 * writing.
 */

#define MI_NOSPACE 1

/* PREDICATE_WITHOUT_PAGR
 *
 * Enabling this options allows the analyzer to accept incomplete
 * predicate forms, that precede the question suffix -mI. Otherwise
 * the predicates before -mI would be analyzed with a (most probably)
 * wrong third person singular/plural (null surface) agreement.
 *
 * disabled:   okumuş muyuz -> oku<V><evid><3s> mu<Q><1p>
 * enabled:                 -> oku<V><evid> mu<Q><1p>
 *
 * When disabled, one needs to postprocess the analyses to remove the
 * wrong <3s> tag.
 *
 * Enabling this option increases number of analyses for any
 * predicate, including nominal predicates.
 *
 */

#define PREDICATE_WITHOUT_PAGR 1

/* ALLOW_COMMON_TYPOS
 *
 * Analyze common typos listed in lexicon/common_typos
 *
 * Note that this does not change common typos regarding some suffixes
 * and clitics. 
 *  - For -mI written together with the predicate, see the
 *    option MI_NOSPACE above. 
 *  - Currently we do not allow -dA to be written together with the
 *    preceding word---which we should probably allow optionally.
 *
 * MARK_TYPOS will mark the root forms that resulted from a typo in
 * the output of the analyzer, 
 *
 */

#define ALLOW_COMMON_TYPOS 1
#define MARK_TYPOS 1

/* ANALYZE_lA
 *
 * Analyze the suffix -lA in all contexts.
 *
 * -lA is a productive derivational suffix that makes verbs from noun,
 * adjectives, onomatopoeia, and interjections.
 * However, it also increases the number of analyses per word
 * drastically. 
 *
 * If this option is enabled, lA will be analyzed and the set of stems
 * defined in lexicon/verb_la will be excluded from the root lexicon.
 * Otherwise, -lA will only be analyzed for the onomatopoeic roots,
 * and only the stems in lexicon/verb_la will be include din the
 * analysis.
 *
 */

#define ANALYZE_lA 1

/* AlLOW_mAG
 *
 * If the suffix -mAK precedes another suffix (typically dative
 * -(y)A or accusative -(y)I) `K' is realized as `y'. However,
 * in some (older?) texts it may be spelled with a `ğ' instead.
 * When enabled, this option allows the forms with `ğ'. Otherwise only
 * the standard (y) form is accepted.
 *
 */

#define ALLOW_mAG 1

/* ENDQUOTE_AS_NOUN
 *
 * If set, this option allows interpretation of quotation marks as
 * nouns. This is useful in cases where nouns/noun phrases, and
 * sometimes other words or even complete sentences are used in quotes
 * (meta linguistically). It also helps where foreign words are used
 * in quotation marks or follow suffixes after an apostrophe.
 *
 * This is intended for the cases where quotation symbol or the
 * apostrophe is tokenized apart from the last word of the quoted
 * phrase. If not, the guesser should produce a more informed guess
 * (following the vowel harmony and the other morphophonological
 * processes).
 *
 */

#define ENDQUOTE_AS_NOUN 1

/* PERCENT_AS_PREFIX
 *
 * The percent sign is put before the nouns in Turkish, like %1 or
 * %10.3. Enabling this option puts the pecent sign as a prefix,
 * producing analysis strings like <perc>1<Num:ara>. Since TRmorph
 * does not include any other prefixes with this notation, this might
 * be confusing. By default this option is disabled.
 *
 * (The actual implementation produces <perc> as a prefix in any case, but
 * we move it after the pos tag if this option is disabled).
 */

#define PERCENT_AS_PREFIX 0

/* LOWERCASE_ALPHA
 *
 * This option enables recognizing lowercase letters as <Alpha>.
 *
 * Since we allow <Alpha> to inflect just like nouns, this creates
 * increases the number of analyses. 
 */

#define LOWERCASE_ALPHA 1

/* SEPARATOR_PLUS
 *
 * Use `+' as the separator between the analysis sybols.
 * This seems to be the Xerox convention, and followed by some other
 * analyzers as well.  
 *
 * It may also be useful in case the analyses are to be used in some
 * sort of XML without re-coding the angle brackets.
 */

#define  SEPARATOR_PLUS 0

/* MARK_SUBCATEGORIES 
 *
 * By default we mark subcategoris within angle brackets, using the
 * separator `:'. Disabling this option causes subcatogory markers
 * tobe treated as any other morphological feature.
 */

#define MARK_SUBCATEGORIES 1


/* COLLAPSE_MA_MAK
 *
 * We normally collapse the infinitive forms with -mA and -mAk to a
 * single analysis symbol <vn:inf>. This option allows them to be
 * analyzed separately as <vn:infMA> and <vn:infMAK>. It may be handy
 * for generation.
 */

#define COLLAPSE_MA_MAK 1


/* ALLOW_MREDUP
 *
 * Allow m-reduplication. This allows analysis of second components of
 * reduplicated forms like 'araba maraba' and 'kitap mitap'.
 *
 * This is a mostly colloquial use, and one may want to disable in
 * some cases. It also increases the ambiguous analysis of words that
 * start with 'm'.
 *
 */

#define ALLOW_MREDUP 1

/* DOUBLE_NEGATIVE
 *
 * This enables analysis of words with non-standard redundant
 * duplication of negative suffix -mA in words like
 * 'görmeMEzlikten/duymaMAzlıktan gel-'.
 *
 */

#define DOUBLE_NEGATIVE 1


/* ANALYZE_URLS
 *
 * This enables analysis of some URL/email patterns.
 * We also allow noun inflections of emails and URLs after an
 * apostrophe.
 *
 * Currently this slows down foma considerably, and increases the size
 * of the resulting FST. Default is off.
 *
 */

#define ANALYZE_URLS 0
