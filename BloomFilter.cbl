       IDENTIFICATION DIVISION.
       PROGRAM-ID. BloomFilter.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Holds the Bloom filter state, initialized to all zeros.
       01 Bloom-Filter.
           05 Filter-Array         PIC X(100) VALUE ALL '0'.

      *> Stores the numbers entered by the user.
       01 Input-Numbers.
           05 Stored-Number        PIC 9(10) OCCURS 5 TIMES.

      *> Stores the randomly generated numbers for checking.
       01 Random-Numbers.
           05 Additional-Number    PIC 9(10) OCCURS 5 TIMES.

      *> Temporary storage for random number generation.
       01 WS-Random                PIC 9(10).

      *> User input buffer.
       01 Input-String             PIC X(10).

      *> Currently processed number for hashing.
       01 Current-Number           PIC 9(10).

      *> Positions in the filter array determined by hash functions.
       01 Hash1-Pos                PIC 99.
       01 Hash2-Pos                PIC 99.

      *> Loop counters.
       01 I                        PIC 9 VALUE 1.
       01 J                        PIC 9.

       PROCEDURE DIVISION.
      *> Populate the Bloom filter with user input.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
               DISPLAY "Enter a number to add to the Bloom filter: "
               ACCEPT Input-String
               MOVE FUNCTION NUMVAL(Input-String) TO Stored-Number(I)
               MOVE Stored-Number(I) TO Current-Number

               PERFORM Calculate-Hashes

               MOVE '1' TO Filter-Array(Hash1-Pos:1)
               MOVE '1' TO Filter-Array(Hash2-Pos:1)
           END-PERFORM

           DISPLAY "Bloom filter state: " Filter-Array

      *> Generate and display random numbers.
           DISPLAY "Generating 5 random numbers to check in the Bloom filter..."
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
               COMPUTE WS-RANDOM = FUNCTION RANDOM * 999999999 + 1
               MOVE WS-RANDOM TO Additional-Number(I)
               DISPLAY "Generated random number: " Additional-Number(I)
           END-PERFORM

      *> Check user-entered numbers in the Bloom filter.
           DISPLAY "Checking all entered numbers in the Bloom filter..."
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > 5
               DISPLAY "Checking entered number: " Stored-Number(J)
               MOVE Stored-Number(J) TO Current-Number
               PERFORM Calculate-Hashes

               IF Filter-Array(Hash1-Pos:1) = '1' AND
                  Filter-Array(Hash2-Pos:1) = '1'
                   DISPLAY "Number is possibly in the set."
               ELSE
                   DISPLAY "Number is definitely not in the set."
               END-IF
           END-PERFORM

      *> Check randomly generated numbers in the Bloom filter.
           DISPLAY "Checking random numbers in the Bloom filter..."
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > 5
               DISPLAY "Checking random number: " Additional-Number(J)
               MOVE Additional-Number(J) TO Current-Number
               PERFORM Calculate-Hashes

               IF Filter-Array(Hash1-Pos:1) = '1' AND
                  Filter-Array(Hash2-Pos:1) = '1'
                   DISPLAY "Random number is possibly in the set."
               ELSE
                   DISPLAY "Random number is definitely not in the set."
               END-IF
           END-PERFORM

           STOP RUN.

      *> Hash calculation using modular arithmetic.
      *> Note that these are simple modulus oprations. Production
      *> implementations should implement more sophisticated functions
      *> to reduce collisions and improve the distribution of hash
      *> values. Also note that this currently only works for numbers
      *> and in many cases you will want the hash for strings.
       Calculate-Hashes.
           COMPUTE Hash1-Pos = FUNCTION MOD(Current-Number, 100) + 1
           COMPUTE Hash2-Pos = FUNCTION MOD(Current-Number * 7, 100) + 1
           DISPLAY "Hash1-Pos: " Hash1-Pos
           DISPLAY "Hash2-Pos: " Hash2-Pos
           .

       END PROGRAM BloomFilter.
