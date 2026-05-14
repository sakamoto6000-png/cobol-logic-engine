       IDENTIFICATION DIVISION.
       PROGRAM-ID. PARSER-UNIT.

      *---------------------------------------------------------------*
      * PROJECT   : COBOL Logic Engine: The Immutable Core
      * ARCHITECT : Takanori Sakamoto
      * FUNCTION  : Physical Buffer Boundary Parsing
      *             (Space-Independent Stream Parser)
      *---------------------------------------------------------------*

       DATA DIVISION.

       WORKING-STORAGE SECTION.

           01 WS-WORD              PIC X(20).

       LINKAGE SECTION.

           01 LK-BUFFER            PIC X(100).
           01 LK-PTR               PIC 9(03).
           01 LK-OUT-TID           PIC 9(02).
           01 LK-EOS-FLAG          PIC 9.

       PROCEDURE DIVISION USING LK-BUFFER
                                LK-PTR
                                LK-OUT-TID
                                LK-EOS-FLAG.

           MOVE 0 TO LK-OUT-TID.

      *    Physical end-of-buffer detection

           IF LK-PTR >
              FUNCTION LENGTH(LK-BUFFER)

              OR LK-BUFFER(LK-PTR:) = SPACES

               MOVE 1 TO LK-EOS-FLAG

               EXIT PROGRAM

           END-IF.

      *    Stream token extraction

           UNSTRING LK-BUFFER
               DELIMITED BY ALL ' ,.!'

               INTO WS-WORD

               WITH POINTER LK-PTR

           END-UNSTRING.

      *    Semantic token conversion

           EVALUATE WS-WORD

               WHEN "NOT"

                   MOVE 01 TO LK-OUT-TID

               WHEN "TYPE-A"

                   MOVE 02 TO LK-OUT-TID

               WHEN "TYPE-B"

                   MOVE 03 TO LK-OUT-TID

               WHEN SPACES

                   MOVE 00 TO LK-OUT-TID

               WHEN OTHER

                   MOVE 99 TO LK-OUT-TID

           END-EVALUATE.

           EXIT PROGRAM.
