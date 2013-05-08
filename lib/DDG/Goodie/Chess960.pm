package DDG::Goodie::Chess960;

use strict;

use DDG::Goodie;

triggers any => 'random', 'chess960';
zci is_cached => 0;
zci answer_type => 'chess960_position';

primary_example_queries 'chess960';
description 'Generates a random starting position for Chess960';
attribution github  => 'https://github.com/koosha--',
            twitter => 'https://twitter.com/_koosha_';

handle query => sub {
    my $query = $_;
    my $pos = undef;
    return unless ($query =~ /\bchess960\b/i && 
            ($query =~ /\brandom\b/i || (($pos) = $query =~ /\b(\d+)\b/))) ;
    my @all_positions = qw(
BBQNNRKR BQNBNRKR BQNNRBKR BQNNRKRB QBBNNRKR QNBBNRKR QNBNRBKR QNBNRKRB QBNNBRKR QNNBBRKR
QNNRBBKR QNNRBKRB QBNNRKBR QNNBRKBR QNNRKBBR QNNRKRBB BBNQNRKR BNQBNRKR BNQNRBKR BNQNRKRB
NBBQNRKR NQBBNRKR NQBNRBKR NQBNRKRB NBQNBRKR NQNBBRKR NQNRBBKR NQNRBKRB NBQNRKBR NQNBRKBR
NQNRKBBR NQNRKRBB BBNNQRKR BNNBQRKR BNNQRBKR BNNQRKRB NBBNQRKR NNBBQRKR NNBQRBKR NNBQRKRB
NBNQBRKR NNQBBRKR NNQRBBKR NNQRBKRB NBNQRKBR NNQBRKBR NNQRKBBR NNQRKRBB BBNNRQKR BNNBRQKR
BNNRQBKR BNNRQKRB NBBNRQKR NNBBRQKR NNBRQBKR NNBRQKRB NBNRBQKR NNRBBQKR NNRQBBKR NNRQBKRB
NBNRQKBR NNRBQKBR NNRQKBBR NNRQKRBB BBNNRKQR BNNBRKQR BNNRKBQR BNNRKQRB NBBNRKQR NNBBRKQR
NNBRKBQR NNBRKQRB NBNRBKQR NNRBBKQR NNRKBBQR NNRKBQRB NBNRKQBR NNRBKQBR NNRKQBBR NNRKQRBB
BBNNRKRQ BNNBRKRQ BNNRKBRQ BNNRKRQB NBBNRKRQ NNBBRKRQ NNBRKBRQ NNBRKRQB NBNRBKRQ NNRBBKRQ
NNRKBBRQ NNRKBRQB NBNRKRBQ NNRBKRBQ NNRKRBBQ NNRKRQBB BBQNRNKR BQNBRNKR BQNRNBKR BQNRNKRB
QBBNRNKR QNBBRNKR QNBRNBKR QNBRNKRB QBNRBNKR QNRBBNKR QNRNBBKR QNRNBKRB QBNRNKBR QNRBNKBR
QNRNKBBR QNRNKRBB BBNQRNKR BNQBRNKR BNQRNBKR BNQRNKRB NBBQRNKR NQBBRNKR NQBRNBKR NQBRNKRB
NBQRBNKR NQRBBNKR NQRNBBKR NQRNBKRB NBQRNKBR NQRBNKBR NQRNKBBR NQRNKRBB BBNRQNKR BNRBQNKR
BNRQNBKR BNRQNKRB NBBRQNKR NRBBQNKR NRBQNBKR NRBQNKRB NBRQBNKR NRQBBNKR NRQNBBKR NRQNBKRB
NBRQNKBR NRQBNKBR NRQNKBBR NRQNKRBB BBNRNQKR BNRBNQKR BNRNQBKR BNRNQKRB NBBRNQKR NRBBNQKR
NRBNQBKR NRBNQKRB NBRNBQKR NRNBBQKR NRNQBBKR NRNQBKRB NBRNQKBR NRNBQKBR NRNQKBBR NRNQKRBB
BBNRNKQR BNRBNKQR BNRNKBQR BNRNKQRB NBBRNKQR NRBBNKQR NRBNKBQR NRBNKQRB NBRNBKQR NRNBBKQR
NRNKBBQR NRNKBQRB NBRNKQBR NRNBKQBR NRNKQBBR NRNKQRBB BBNRNKRQ BNRBNKRQ BNRNKBRQ BNRNKRQB
NBBRNKRQ NRBBNKRQ NRBNKBRQ NRBNKRQB NBRNBKRQ NRNBBKRQ NRNKBBRQ NRNKBRQB NBRNKRBQ NRNBKRBQ
NRNKRBBQ NRNKRQBB BBQNRKNR BQNBRKNR BQNRKBNR BQNRKNRB QBBNRKNR QNBBRKNR QNBRKBNR QNBRKNRB
QBNRBKNR QNRBBKNR QNRKBBNR QNRKBNRB QBNRKNBR QNRBKNBR QNRKNBBR QNRKNRBB BBNQRKNR BNQBRKNR
BNQRKBNR BNQRKNRB NBBQRKNR NQBBRKNR NQBRKBNR NQBRKNRB NBQRBKNR NQRBBKNR NQRKBBNR NQRKBNRB
NBQRKNBR NQRBKNBR NQRKNBBR NQRKNRBB BBNRQKNR BNRBQKNR BNRQKBNR BNRQKNRB NBBRQKNR NRBBQKNR
NRBQKBNR NRBQKNRB NBRQBKNR NRQBBKNR NRQKBBNR NRQKBNRB NBRQKNBR NRQBKNBR NRQKNBBR NRQKNRBB
BBNRKQNR BNRBKQNR BNRKQBNR BNRKQNRB NBBRKQNR NRBBKQNR NRBKQBNR NRBKQNRB NBRKBQNR NRKBBQNR
NRKQBBNR NRKQBNRB NBRKQNBR NRKBQNBR NRKQNBBR NRKQNRBB BBNRKNQR BNRBKNQR BNRKNBQR BNRKNQRB
NBBRKNQR NRBBKNQR NRBKNBQR NRBKNQRB NBRKBNQR NRKBBNQR NRKNBBQR NRKNBQRB NBRKNQBR NRKBNQBR
NRKNQBBR NRKNQRBB BBNRKNRQ BNRBKNRQ BNRKNBRQ BNRKNRQB NBBRKNRQ NRBBKNRQ NRBKNBRQ NRBKNRQB
NBRKBNRQ NRKBBNRQ NRKNBBRQ NRKNBRQB NBRKNRBQ NRKBNRBQ NRKNRBBQ NRKNRQBB BBQNRKRN BQNBRKRN
BQNRKBRN BQNRKRNB QBBNRKRN QNBBRKRN QNBRKBRN QNBRKRNB QBNRBKRN QNRBBKRN QNRKBBRN QNRKBRNB
QBNRKRBN QNRBKRBN QNRKRBBN QNRKRNBB BBNQRKRN BNQBRKRN BNQRKBRN BNQRKRNB NBBQRKRN NQBBRKRN
NQBRKBRN NQBRKRNB NBQRBKRN NQRBBKRN NQRKBBRN NQRKBRNB NBQRKRBN NQRBKRBN NQRKRBBN NQRKRNBB
BBNRQKRN BNRBQKRN BNRQKBRN BNRQKRNB NBBRQKRN NRBBQKRN NRBQKBRN NRBQKRNB NBRQBKRN NRQBBKRN
NRQKBBRN NRQKBRNB NBRQKRBN NRQBKRBN NRQKRBBN NRQKRNBB BBNRKQRN BNRBKQRN BNRKQBRN BNRKQRNB
NBBRKQRN NRBBKQRN NRBKQBRN NRBKQRNB NBRKBQRN NRKBBQRN NRKQBBRN NRKQBRNB NBRKQRBN NRKBQRBN
NRKQRBBN NRKQRNBB BBNRKRQN BNRBKRQN BNRKRBQN BNRKRQNB NBBRKRQN NRBBKRQN NRBKRBQN NRBKRQNB
NBRKBRQN NRKBBRQN NRKRBBQN NRKRBQNB NBRKRQBN NRKBRQBN NRKRQBBN NRKRQNBB BBNRKRNQ BNRBKRNQ
BNRKRBNQ BNRKRNQB NBBRKRNQ NRBBKRNQ NRBKRBNQ NRBKRNQB NBRKBRNQ NRKBBRNQ NRKRBBNQ NRKRBNQB
NBRKRNBQ NRKBRNBQ NRKRNBBQ NRKRNQBB BBQRNNKR BQRBNNKR BQRNNBKR BQRNNKRB QBBRNNKR QRBBNNKR
QRBNNBKR QRBNNKRB QBRNBNKR QRNBBNKR QRNNBBKR QRNNBKRB QBRNNKBR QRNBNKBR QRNNKBBR QRNNKRBB
BBRQNNKR BRQBNNKR BRQNNBKR BRQNNKRB RBBQNNKR RQBBNNKR RQBNNBKR RQBNNKRB RBQNBNKR RQNBBNKR
RQNNBBKR RQNNBKRB RBQNNKBR RQNBNKBR RQNNKBBR RQNNKRBB BBRNQNKR BRNBQNKR BRNQNBKR BRNQNKRB
RBBNQNKR RNBBQNKR RNBQNBKR RNBQNKRB RBNQBNKR RNQBBNKR RNQNBBKR RNQNBKRB RBNQNKBR RNQBNKBR
RNQNKBBR RNQNKRBB BBRNNQKR BRNBNQKR BRNNQBKR BRNNQKRB RBBNNQKR RNBBNQKR RNBNQBKR RNBNQKRB
RBNNBQKR RNNBBQKR RNNQBBKR RNNQBKRB RBNNQKBR RNNBQKBR RNNQKBBR RNNQKRBB BBRNNKQR BRNBNKQR
BRNNKBQR BRNNKQRB RBBNNKQR RNBBNKQR RNBNKBQR RNBNKQRB RBNNBKQR RNNBBKQR RNNKBBQR RNNKBQRB
RBNNKQBR RNNBKQBR RNNKQBBR RNNKQRBB BBRNNKRQ BRNBNKRQ BRNNKBRQ BRNNKRQB RBBNNKRQ RNBBNKRQ
RNBNKBRQ RNBNKRQB RBNNBKRQ RNNBBKRQ RNNKBBRQ RNNKBRQB RBNNKRBQ RNNBKRBQ RNNKRBBQ RNNKRQBB
BBQRNKNR BQRBNKNR BQRNKBNR BQRNKNRB QBBRNKNR QRBBNKNR QRBNKBNR QRBNKNRB QBRNBKNR QRNBBKNR
QRNKBBNR QRNKBNRB QBRNKNBR QRNBKNBR QRNKNBBR QRNKNRBB BBRQNKNR BRQBNKNR BRQNKBNR BRQNKNRB
RBBQNKNR RQBBNKNR RQBNKBNR RQBNKNRB RBQNBKNR RQNBBKNR RQNKBBNR RQNKBNRB RBQNKNBR RQNBKNBR
RQNKNBBR RQNKNRBB BBRNQKNR BRNBQKNR BRNQKBNR BRNQKNRB RBBNQKNR RNBBQKNR RNBQKBNR RNBQKNRB
RBNQBKNR RNQBBKNR RNQKBBNR RNQKBNRB RBNQKNBR RNQBKNBR RNQKNBBR RNQKNRBB BBRNKQNR BRNBKQNR
BRNKQBNR BRNKQNRB RBBNKQNR RNBBKQNR RNBKQBNR RNBKQNRB RBNKBQNR RNKBBQNR RNKQBBNR RNKQBNRB
RBNKQNBR RNKBQNBR RNKQNBBR RNKQNRBB BBRNKNQR BRNBKNQR BRNKNBQR BRNKNQRB RBBNKNQR RNBBKNQR
RNBKNBQR RNBKNQRB RBNKBNQR RNKBBNQR RNKNBBQR RNKNBQRB RBNKNQBR RNKBNQBR RNKNQBBR RNKNQRBB
BBRNKNRQ BRNBKNRQ BRNKNBRQ BRNKNRQB RBBNKNRQ RNBBKNRQ RNBKNBRQ RNBKNRQB RBNKBNRQ RNKBBNRQ
RNKNBBRQ RNKNBRQB RBNKNRBQ RNKBNRBQ RNKNRBBQ RNKNRQBB BBQRNKRN BQRBNKRN BQRNKBRN BQRNKRNB
QBBRNKRN QRBBNKRN QRBNKBRN QRBNKRNB QBRNBKRN QRNBBKRN QRNKBBRN QRNKBRNB QBRNKRBN QRNBKRBN
QRNKRBBN QRNKRNBB BBRQNKRN BRQBNKRN BRQNKBRN BRQNKRNB RBBQNKRN RQBBNKRN RQBNKBRN RQBNKRNB
RBQNBKRN RQNBBKRN RQNKBBRN RQNKBRNB RBQNKRBN RQNBKRBN RQNKRBBN RQNKRNBB BBRNQKRN BRNBQKRN
BRNQKBRN BRNQKRNB RBBNQKRN RNBBQKRN RNBQKBRN RNBQKRNB RBNQBKRN RNQBBKRN RNQKBBRN RNQKBRNB
RBNQKRBN RNQBKRBN RNQKRBBN RNQKRNBB BBRNKQRN BRNBKQRN BRNKQBRN BRNKQRNB RBBNKQRN RNBBKQRN
RNBKQBRN RNBKQRNB RBNKBQRN RNKBBQRN RNKQBBRN RNKQBRNB RBNKQRBN RNKBQRBN RNKQRBBN RNKQRNBB
BBRNKRQN BRNBKRQN BRNKRBQN BRNKRQNB RBBNKRQN RNBBKRQN RNBKRBQN RNBKRQNB RBNKBRQN RNKBBRQN
RNKRBBQN RNKRBQNB RBNKRQBN RNKBRQBN RNKRQBBN RNKRQNBB BBRNKRNQ BRNBKRNQ BRNKRBNQ BRNKRNQB
RBBNKRNQ RNBBKRNQ RNBKRBNQ RNBKRNQB RBNKBRNQ RNKBBRNQ RNKRBBNQ RNKRBNQB RBNKRNBQ RNKBRNBQ
RNKRNBBQ RNKRNQBB BBQRKNNR BQRBKNNR BQRKNBNR BQRKNNRB QBBRKNNR QRBBKNNR QRBKNBNR QRBKNNRB
QBRKBNNR QRKBBNNR QRKNBBNR QRKNBNRB QBRKNNBR QRKBNNBR QRKNNBBR QRKNNRBB BBRQKNNR BRQBKNNR
BRQKNBNR BRQKNNRB RBBQKNNR RQBBKNNR RQBKNBNR RQBKNNRB RBQKBNNR RQKBBNNR RQKNBBNR RQKNBNRB
RBQKNNBR RQKBNNBR RQKNNBBR RQKNNRBB BBRKQNNR BRKBQNNR BRKQNBNR BRKQNNRB RBBKQNNR RKBBQNNR
RKBQNBNR RKBQNNRB RBKQBNNR RKQBBNNR RKQNBBNR RKQNBNRB RBKQNNBR RKQBNNBR RKQNNBBR RKQNNRBB
BBRKNQNR BRKBNQNR BRKNQBNR BRKNQNRB RBBKNQNR RKBBNQNR RKBNQBNR RKBNQNRB RBKNBQNR RKNBBQNR
RKNQBBNR RKNQBNRB RBKNQNBR RKNBQNBR RKNQNBBR RKNQNRBB BBRKNNQR BRKBNNQR BRKNNBQR BRKNNQRB
RBBKNNQR RKBBNNQR RKBNNBQR RKBNNQRB RBKNBNQR RKNBBNQR RKNNBBQR RKNNBQRB RBKNNQBR RKNBNQBR
RKNNQBBR RKNNQRBB BBRKNNRQ BRKBNNRQ BRKNNBRQ BRKNNRQB RBBKNNRQ RKBBNNRQ RKBNNBRQ RKBNNRQB
RBKNBNRQ RKNBBNRQ RKNNBBRQ RKNNBRQB RBKNNRBQ RKNBNRBQ RKNNRBBQ RKNNRQBB BBQRKNRN BQRBKNRN
BQRKNBRN BQRKNRNB QBBRKNRN QRBBKNRN QRBKNBRN QRBKNRNB QBRKBNRN QRKBBNRN QRKNBBRN QRKNBRNB
QBRKNRBN QRKBNRBN QRKNRBBN QRKNRNBB BBRQKNRN BRQBKNRN BRQKNBRN BRQKNRNB RBBQKNRN RQBBKNRN
RQBKNBRN RQBKNRNB RBQKBNRN RQKBBNRN RQKNBBRN RQKNBRNB RBQKNRBN RQKBNRBN RQKNRBBN RQKNRNBB
BBRKQNRN BRKBQNRN BRKQNBRN BRKQNRNB RBBKQNRN RKBBQNRN RKBQNBRN RKBQNRNB RBKQBNRN RKQBBNRN
RKQNBBRN RKQNBRNB RBKQNRBN RKQBNRBN RKQNRBBN RKQNRNBB BBRKNQRN BRKBNQRN BRKNQBRN BRKNQRNB
RBBKNQRN RKBBNQRN RKBNQBRN RKBNQRNB RBKNBQRN RKNBBQRN RKNQBBRN RKNQBRNB RBKNQRBN RKNBQRBN
RKNQRBBN RKNQRNBB BBRKNRQN BRKBNRQN BRKNRBQN BRKNRQNB RBBKNRQN RKBBNRQN RKBNRBQN RKBNRQNB
RBKNBRQN RKNBBRQN RKNRBBQN RKNRBQNB RBKNRQBN RKNBRQBN RKNRQBBN RKNRQNBB BBRKNRNQ BRKBNRNQ
BRKNRBNQ BRKNRNQB RBBKNRNQ RKBBNRNQ RKBNRBNQ RKBNRNQB RBKNBRNQ RKNBBRNQ RKNRBBNQ RKNRBNQB
RBKNRNBQ RKNBRNBQ RKNRNBBQ RKNRNQBB BBQRKRNN BQRBKRNN BQRKRBNN BQRKRNNB QBBRKRNN QRBBKRNN
QRBKRBNN QRBKRNNB QBRKBRNN QRKBBRNN QRKRBBNN QRKRBNNB QBRKRNBN QRKBRNBN QRKRNBBN QRKRNNBB
BBRQKRNN BRQBKRNN BRQKRBNN BRQKRNNB RBBQKRNN RQBBKRNN RQBKRBNN RQBKRNNB RBQKBRNN RQKBBRNN
RQKRBBNN RQKRBNNB RBQKRNBN RQKBRNBN RQKRNBBN RQKRNNBB BBRKQRNN BRKBQRNN BRKQRBNN BRKQRNNB
RBBKQRNN RKBBQRNN RKBQRBNN RKBQRNNB RBKQBRNN RKQBBRNN RKQRBBNN RKQRBNNB RBKQRNBN RKQBRNBN
RKQRNBBN RKQRNNBB BBRKRQNN BRKBRQNN BRKRQBNN BRKRQNNB RBBKRQNN RKBBRQNN RKBRQBNN RKBRQNNB
RBKRBQNN RKRBBQNN RKRQBBNN RKRQBNNB RBKRQNBN RKRBQNBN RKRQNBBN RKRQNNBB BBRKRNQN BRKBRNQN
BRKRNBQN BRKRNQNB RBBKRNQN RKBBRNQN RKBRNBQN RKBRNQNB RBKRBNQN RKRBBNQN RKRNBBQN RKRNBQNB
RBKRNQBN RKRBNQBN RKRNQBBN RKRNQNBB BBRKRNNQ BRKBRNNQ BRKRNBNQ BRKRNNQB RBBKRNNQ RKBBRNNQ
RKBRNBNQ RKBRNNQB RBKRBNNQ RKRBBNNQ RKRNBBNQ RKRNBNQB RBKRNNBQ RKRBNNBQ RKRNNBBQ RKRNNQBB
);

    my $position = ($pos && 1 <= $pos && $pos <= 960) ? 
                    $all_positions[$pos - 1] : 
                    $all_positions[int rand @all_positions];

    my $output = "White: " . join(" ", split("", $position)) . "\n" .
                 "       " . "P " x 8 . "\n" .
                 "Black: " . join(" ", split("", $position)) . "\n" .
                 "       " . "P " x 8 . "\n\n" .
                 "(where B is for bishop,\n" .
                 "       K is for king,\n" .
                 "       N is for knight,\n" .
                 "       Q is for queen,\n" .
                 "       R is for rook, and\n" .
                 "       P is for pawn)";
    my $position_lc = lc $position;
    my $html = "<img src='/iu/?u=http://www.apronus.com/chess/stilldiagram.php?d=P${position}PPPPPPPP________________________________pppppppp${position_lc}0.jpg&w=8&h=8'/>";

    $query =~ s/^ chess960|chess960 $|chess960 //i;
    return $output, html => $html, heading => "$query (Chess960)";
};

1;
