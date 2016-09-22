bookList := select (type='ART')(book);
bookWritten := wrote njoin bookList;
bookAuthor := bookWritten njoin author;
result := project bookCode, title, price, authorLast, authorFirst, sequence (bookAuthor);