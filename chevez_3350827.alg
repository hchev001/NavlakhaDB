% Assignment #2 - WinRDBI
% COP 4710 U)1 T/Thu 12:30-1:45 PM
% Name: Hamilton Chevez
% PID: 3350827
% I hereby certify that this has been of my own work.




%QUERY # 1
%bookList := select (type='ART')(book);
%bookWritten := wrote njoin bookList;
%bookAuthor := bookWritten njoin author;
%qOneSolution := project bookCode, title, price, authorLast, authorFirst, sequence (bookAuthor);

%QUERY #2
%ficBooks := project bookCode (select (type = 'FIC')(book));
%bookReferences := project authorNum (ficBooks njoin wrote);
%qTwoSolution := project authorLast, authorFirst (bookReferences njoin author);

%QUERY # 3
%jp_Public(pC) := project publisherCode(select (publisherName = 'Jove Publications') (publisher));
%bookList := project bookCode, publisherCode (book);
%temp := jp_Public product bookList;
%jpBooks(bCode, pC) := project bookCode, pC (select (pC = publisherCode) (temp));
%jpBookAuth := select (bookCode = bCode) (jpBooks product (project bookCode, authorNum (wrote)));
%qThreeSolution := author njoin (project authorNum (jpBookAuth));

%QUERY # 4
%inventF(bkCode, brNum) := project bookCode, branchNum (inventory);
%temp1 := inventF product (project bookCode, authorNum (wrote));
%notHenryBookC := select (bkCode <> bookCode) (temp1);
%temp2 := notHenryBookC njoin author;
%qFourSolution := project authorLast, authorFirst (temp2);



%t1(hbBookCodes) := project bookCode (copy);
%t2 := select (hbBookCodes = bookCode)(t1 product wrote);
%t3(autN, authorLast, authorFirst) := author;
%t4 := select (authorNum = autN)(t2 product t3);
%t5 := project bookCode (inventory);


%QUERY #5 %
%goodBooks := project bookCode, branchNum ( select (quality = 'Good') (copy));
%wroteM:= goodBooks njoin wrote;
%wroteBranch := project bookCode, branchNum, authorNum, sequence, branchName ( wroteM njoin branch);
%temp1 := project bookCode, title (book);
%wBranchTitle := wroteBranch njoin temp1;
%wBranchAuth := wBranchTitle njoin author;
%qFiveSolution := project title, branchName, authorFirst, authorLast, sequence (wBranchAuth);

%QUERY #6 
%books := wrote njoin (project bookCode, title (book));
%temp(autNum, authorLast, authorFirst) := project authorNum, authorLast, authorFirst (author);
%booksAut1 := (project authorNum (author)) njoin books;
%temp1 := booksAut1 product temp;
%booksAut2 := select (authorNum = autNum) (booksAut1 product temp);
%wrote1(n1, bc1) := project authorNum, bookCode (booksAut2);
%wrote2(n2, bc2) := wrote1;
%wTemp := wrote1 product wrote2;
%ws1 := select (bc1 <> bc2)(wTemp);
%ws2 := select (n1 = n2)(ws1);
%qSixResult := project n1 (ws2);

%QUERY #7
%t1(bkC, brnchN, cpyN, qlt) := project bookCode, branchNum, copyNum, quality (copy);
%t2 := t1 product wrote;
%t3 := select (qlt = 'Excellent')(t2);
%t4 := select (qlt = 'Good')(t2);
%t5 := select (qlt = 'Fair')(t2);
%t6 := select (qlt = 'Poor')(t2);
%excll := project bkC (t3);
%gdd := project bkC (t4);
%frr := project bkC (t5);
%prr := project bkC(t6);
%qSevenSolution := (excll intersect gdd) intersect (frr intersect prr);












