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

/*
 * CAPITALIZE: this allows first letter of  any word to be capital. This 
 *             is fits typical use case of an analyzer. One may want to 
 *             disable this for generation.
 * ALLCAPS:    Analyze and generate words that are in ALL CAPITAL LETTERS.
 *
 */

#define ALLCAPS 1
#define CAPITALIZE 1
#define GUESSER_ALLCAPS 0
#define GUESSER_CAPITALIZE 0

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
 * This option is currenly global. It cannot be customized for
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

#define GUESSER_MIN_LENGTH 3
#define GUESSER_MAX_LENGTH 10
#define GUESSER_STEM 1

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
 * This is inccorrect spelling, but a very common mistake in informal
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
