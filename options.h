/* 
 * This file lists some configurable options for building various
 * components of TRmoprh. The file is simply a C preprocessor file
 * with #define directives. The options and their use are specified
 * below. Currently this file is only used by the guesser code.
 *
 */

/* 
 * APOSTROPHE_REQUIRED Require apostrophe after proper names and
 *                     numbers.
 * APOSTROPHE_OPTIONAL Apostrophe use is optional, analyze/generate
 *                     words where apostrophe is skipped.
 * 
 * Normally you should set one of these to 1. If both are set,
 * APOSTROPHE_OPTIONAL takes precedence, if none set, 
 * APOSTROPHE_REQUIRED is assumed.
 * 
 * NOTE: currently,  TRmorph's apostrophe insertion does not fully
 * comply with the official spelling rules.
 */
#define APOSTROPHE_OPTIONAL 1
#define APOSTROPHE_REQUIRED 0


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
 * differnt components here.
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
 * These options are only for guesser. The gusser will attempt to
 * guess the words whose length is in range GUESSER_MIN_LENGTH -
 * GUESSER_MAX_LENGTH.
 */

#define GUESSER_MIN_LENGTH 3
#define GUESSER_MAX_LENGTH 10

/* ----------------- end of configurable options -------------- */


#ifndef GUESSER_APOSTROPHE_OPTIONAL
#define GUESSER_APOSTROPHE_OPTIONAL APOSTROPHE_OPTIONAL
#endif

#ifndef GUESSER_APOSTROPHE_REQUIRED
#define GUESSER_APOSTROPHE_REQUIRED APOSTROPHE_REQUIRED
#endif

#ifndef GUESSER_ALLCAPS
#define GUESSER_ALLCAPS ALLCAPS
#endif

#ifndef GUESSER_CAPITALIZE
#define GUESSER_CAPITALIZE CAPITALIZE
#endif

#ifndef GUESSER_CIRCUMFLEX_OPTIONAL
#define GUESSER_CIRCUMFLEX_OPTIONAL CIRCUMFLEX_OPTIONAL
#endif


/* ---------- */


#ifndef ANALYZER_APOSTROPHE_OPTIONAL
#define ANALYZER_APOSTROPHE_OPTIONAL APOSTROPHE_OPTIONAL
#endif

#ifndef ANALYZER_APOSTROPHE_REQUIRED
#define ANALYZER_APOSTROPHE_REQUIRED APOSTROPHE_REQUIRED
#endif

#ifndef ANALYZER_ALLCAPS
#define ANALYZER_ALLCAPS ALLCAPS
#endif

#ifndef ANALYZER_CAPITALIZE
#define ANALYZER_CAPITALIZE CAPITALIZE
#endif

#ifndef ANALYZER_CIRCUMFLEX_OPTIONAL
#define ANALYZER_CIRCUMFLEX_OPTIONAL CIRCUMFLEX_OPTIONAL
#endif
