#lang racket

(define input-list '(("Hungary" (("Spain" 12)("Bulgaria" 10) ("Cyprus" 8) ("Portugal" 7) ("Germany" 6) ("Croaita" 5) ("France" 4) ("Cyprus" 3) ("Belgium" 2) ("Iceland" 1)))
                  ("Spain" (("Bulgaria" 12) ("Cyprus" 10) ("Portugal" 8) ("Germany" 7) ("Croaita" 6) ("France" 5) ("Cyprus" 4) ("Belgium" 3) ("Iceland" 2) ("Denmark" 1)))
                  ("Greece" (("Cyprus" 12) ("Portugal" 10) ("Germany" 8)("Croaita" 7) ("France" 6) ("Cyprus" 5) ("Belgium" 4) ("Iceland" 3) ("Denmark" 2) ("Finland" 1)))
                  ("Armenia" (("Portugal" 12) ("Germany" 10) ("Croaita" 8) ("France" 7) ("Cyprus" 6) ("Belgium" 5) ("Iceland" 4) ("Denmark" 3) ("Finland" 2) ("Estonia" 1)))
                  ("Portugal" (("Germany" 12) ("Croaita" 10) ("France" 8) ("Cyprus" 7) ("Belgium" 6) ("Denmark" 5) ("Finland" 4) ("Estonia" 3) ("Finland" 2) ("Iceland" 1)))
                  ("Bulgaria" (("Croaita" 12) ("Germany" 10) ("Croaita" 8) ("Finland" 7) ("Cyprus" 6) ("Belgium" 5) ("Iceland" 4) ("Denmark" 3) ("Finland" 2) ("Hungary" 1)))
                  ("Iceland" (("Portugal" 12) ("Bulgaria" 10) ("Germany" 8) ("France" 7) ("Cyprus" 6) ("Belgium" 5) ("Spain" 4) ("Denmark" 3) ("Finland" 2) ("Estonia" 1)))
                  ("Greece" (("Cyprus" 12) ("Portugal" 10) ("Hungary" 8) ("Croaita" 7) ("France" 6) ("Cyprus" 5) ("Belgium" 4) ("Iceland" 3) ("Denmark" 2) ("Finland" 1)))))

(define (check-for-same-name country input-list)
  (if (null? input-list)
      #t
      (if (equal? country (caar input-list))
          #f
          (check-for-same-name country (cdr input-list)))))


(define (eurovision input-list sub-list first-bool (Hungary 0)(Spain 0)(Bulgaria 0)(Cyprus 0)(Greece 0)(Belgium 0)(Iceland 0)(Denmark 0)(Finland 0)(Estonia 0)(Germany 0)
                              (Armenia 0)(Portugal 0)(Croaita 0)(France 0))
  (if(and(null? input-list)(null? sub-list));Since we give the sub-list in the first function call with (car input-list) we needed to check for if both of them are null or not.
     (sort (list(list "Hungary" Hungary )(list"Spain" Spain)(list "Bulgaria" Bulgaria)(list "Cyprus" Cyprus)(list "Greece" Greece)(list "Belgium" Belgium)(list "Iceland" Iceland)
                          (list "Denmark" Denmark )(list "Finland" Finland )(list "Estonia" Estonia )(list "Germany" Germany )(list "Armenia" Armenia )(list "Portugal" Portugal )(list "Croaita" Croaita )(list "France" France ))
           > #:key second);sorts and returns the list.
     (if(null? sub-list)
        (eurovision (cdr input-list)(cadar input-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France); if the current read sub-list (which is where all the points are stored for a country) is empty returns with recursive call with the next sub-list
        (if (not first-bool);This boolean was for counting the first line, since we give the first sub-list with (car input-list) we had to know if program checked it or not.
            (if(list? (car sub-list));If the current sub-lists first element is a list or not. This was mainly for the cases where a list had a first element as a country rather than for example (Bulgaria 10). The  countrys name thats giving the points.
               (if (or (< 12 (cadar sub-list)) (= 9 (cadar sub-list)) (= 11 (cadar sub-list)) (> 0 (cadar sub-list)));If points are greater than 13 or 9 or 11, displays an error message.
                   (display "Points given by a country has to be 1-2-3-4-5-6-7-8-10 or 12")
                   (if (or (null? input-list) (= 10 (length (cadar input-list))));If the length of the points list is not 10, displays an error message
                       (if (or (null? input-list) (check-for-same-name (caar input-list) (cadar input-list)));If a country gives itself points, displays an error message.
                           (cond ((string=?  (caar sub-list) "Hungary")(eurovision input-list (cdr sub-list) #f  (+ Hungary (cadar sub-list)) Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Spain")(eurovision input-list (cdr sub-list)#f Hungary (+ Spain(cadar sub-list)) Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Bulgaria")(eurovision input-list (cdr sub-list)#f Hungary Spain (+ Bulgaria (cadar sub-list)) Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Cyprus")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria (+ Cyprus(cadar sub-list)) Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Greece")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus (+ Greece (cadar sub-list)) Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Belgium")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece (+ Belgium (cadar sub-list)) Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Iceland")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium (+ Iceland (cadar sub-list)) Denmark Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Denmark")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland (+ Denmark (cadar sub-list)) Finland Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Finland")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark (+ Finland (cadar sub-list)) Estonia Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Estonia")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland (+ Estonia (cadar sub-list)) Germany Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Germany")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia (+ Germany (cadar sub-list)) Armenia Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Armenia")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany (+ Armenia (cadar sub-list)) Portugal Croaita France))
                                 ((string=?  (caar sub-list) "Portugal")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia (+ Portugal (cadar sub-list)) Croaita France))
                                 ((string=?  (caar sub-list) "Croaita")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal (+ Croaita (cadar sub-list)) France))
                                 ((string=?  (caar sub-list) "France")(eurovision input-list (cdr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita (+ France (cadar sub-list)))))
                           (display "A country can not give points to itself!"))
                       (display "Input size for a country's points are greater than 10")))
               (eurovision input-list (cadr sub-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France))
            (eurovision (cdr input-list)(cadar input-list)#f Hungary Spain Bulgaria Cyprus Greece Belgium Iceland Denmark Finland Estonia Germany Armenia Portugal Croaita France)))))

(eurovision input-list (car input-list) #t)