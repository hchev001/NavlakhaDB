%QUERY # 1
%bookList := select (type='ART')(book);
%bookWritten := wrote njoin bookList;
%bookAuthor := bookWritten njoin author;
%result := project bookCode, title, price, authorLast, authorFirst, sequence (bookAuthor);

%QUERY #2
%ficBooks := project bookCode (select (type = 'FIC')(book));
%bookReferences := project authorNum (ficBooks njoin wrote);
%ficAuthors := project authorLast, authorFirst (bookReferences njoin author);

%QUERY # 3
jp_Public(pC) := project publisherCode(select (publisherName = 'Jove Publications') (publisher));
bookList := project bookCode, publisherCode (book);
temp := jp_Public product bookList;
jpBooks(bCode, pC) := project bookCode, pC (select (pC = publisherCode) (temp));
jpBookAuth := select (bookCode = bCode) (jpBooks product (project bookCode, authorNum (wrote)));
jpAuthors := author njoin (project authorNum (jpBookAuth));
