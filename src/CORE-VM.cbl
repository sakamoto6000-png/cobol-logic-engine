       IDENTIFICATION DIVISION.
       PROGRAM-ID. CORE-VM.
      *---------------------------------------------------------------*
      * PROJECT   : COBOL Logic Engine: The Immutable Core
      * ARCHITECT : Takanori Sakamoto
      * FUNCTION  : Side-Effect-Free State Transition Engine
      *---------------------------------------------------------------*

       DATA DIVISION.

       LINKAGE SECTION.
           COPY "PROTOCOL.cpy".

           01 LK-IN-TID        PIC 9(02).

       PROCEDURE DIVISION USING LK-IN-TID
                                LK-GLOBAL-STATE
                                LK-TRANSITION-EVENT.

           MOVE 'S' TO RES-STATUS.
           MOVE LK-IN-TID TO RES-TID.

           EVALUATE LK-IN-TID

               WHEN 01
      *            FLIP

                   MOVE 01 TO RES-OPCODE
                   MOVE 0  TO RES-DELTA

                   MULTIPLY -1 BY ST-POLARITY

               WHEN 02
      *            ADD (TYPE-A)

                   MOVE 02 TO RES-OPCODE

                   IF ST-FLAG-BITS(02:1) = '0'

                       MOVE 90 TO RES-DELTA

                       COMPUTE ST-SCORE-INT =
                           ST-SCORE-INT +
                           (RES-DELTA * ST-POLARITY)

                       MOVE '1' TO ST-FLAG-BITS(02:1)

                       MOVE 1 TO ST-POLARITY

                   ELSE

                       MOVE 'D' TO RES-STATUS

                   END-IF

               WHEN 03
      *            ADD (TYPE-B)

                   MOVE 02 TO RES-OPCODE

                   IF ST-FLAG-BITS(03:1) = '0'

                       MOVE 70 TO RES-DELTA

                       COMPUTE ST-SCORE-INT =
                           ST-SCORE-INT +
                           (RES-DELTA * ST-POLARITY)

                       MOVE '1' TO ST-FLAG-BITS(03:1)

                       MOVE 1 TO ST-POLARITY

                   ELSE

                       MOVE 'D' TO RES-STATUS

                   END-IF

               WHEN OTHER

                   MOVE 'E' TO RES-STATUS

           END-EVALUATE.

           EXIT PROGRAM.
