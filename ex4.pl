:- module('ex4',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(a, asimov).
author(h, herbert).
author(m, morris).
author(t, tolkien).

genre(s, science).
genre(l, literature).
genre(sf, science_fiction).
genre(f, fantasy).

book(inside_the_atom, a, s, s(s(s(s(s(zero)))))).
book(asimov_guide_to_shakespeare, a, l, s(s(s(s(zero))))).
book(i_robot, a, sf, s(s(s(zero)))).
book(dune, h, sf, s(s(s(s(s(zero)))))).
book(the_well_at_the_worlds_end, m, f, s(s(s(s(zero))))).
book(the_hobbit, t, f, s(s(s(zero)))).
book(the_lord_of_the_rings, t, f, s(s(s(s(s(s(zero))))))).

% You can add more facts.


% Signature: max_list(Lst, Max)/2
% Purpose: true if Max is the maximum church number in Lst, false if Lst is emoty.

% Base case: empty list returns false
max_list([], false).

% Base case: single element list returns that element
max_list([X], X).

% Recursive case: compare first element with max of rest of list
max_list([H|T], Max) :-
    max_list(T, MaxTail),
    MaxTail \= false,
    compare_church(H, MaxTail, Max).

% Helper predicate to compare two Church numbers
compare_church(N1, N2, N1) :-
    church_greater_or_equal(N1, N2).
compare_church(N1, N2, N2) :-
    church_greater_or_equal(N2, N1).

% Helper predicate to check if first Church number is greater or equal
church_greater_or_equal(s(X), zero).
church_greater_or_equal(s(X), s(Y)) :-
    church_greater_or_equal(X, Y).
church_greater_or_equal(zero, zero).








% Signature: author_of_genre(GenreName, AuthorName)/2
% Purpose: true if an author by the name AuthorName has written a book belonging to the genre named GenreName.

author_of_genre(GenreName, AuthorName) :-
    % Find the genre ID for the given genre name
    genre(GenreId, GenreName),
    % Find a book with that genre ID
    book(_, AuthorId, GenreId, _),
    % Get the author name for that author ID
    author(AuthorId, AuthorName).








% Signature: longest_book(AuthorName, BookName)/2
% Purpose: true if the longest book that an author by the name AuthorName has written is titled BookName.

longest_book(AuthorName, BookName) :-
    % Get author ID from name
    author(AuthorId, AuthorName),
    % Find all books and their lengths for this author
    findall((Length, Title), book(Title, AuthorId, _, Length), Books),
    % Make sure author has at least one book
    Books \= [],
    % Find the book with maximum length
    find_max_book(Books, (_, BookName)).

% Helper predicate to find book with maximum length from list of (Length,Title) pairs
find_max_book([(Length, Title)], (Length, Title)).
find_max_book([(Length1, Title1)|Rest], MaxBook) :-
    find_max_book(Rest, (Length2, Title2)),
    compare_book_lengths((Length1, Title1), (Length2, Title2), MaxBook).

% Compare two books based on their Church number lengths
compare_book_lengths((Length1, Title1), (Length2, Title2), (Length1, Title1)) :-
    church_greater_or_equal(Length1, Length2).
compare_book_lengths((Length1, Title1), (Length2, Title2), (Length2, Title2)) :-
    church_greater_or_equal(Length2, Length1).
