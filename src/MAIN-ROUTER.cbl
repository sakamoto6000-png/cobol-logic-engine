       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN-ROUTER.

      *---------------------------------------------------------------*
      * PROJECT   : COBOL Logic Engine: The Immutable Core
      * ARCHITECT : Takanori Sakamoto
      * FUNCTION  : Deterministic Event Dispatcher
      *             & System Orchestrator
      *---------------------------------------------------------------*

       DATA DIVISION.

       WORKING-STORAGE SECTION.

           COPY "PROTOCOL.cpy"
               REPLACING
                   LK-PROTOCOL-HEADER
                       BY WS-HDR

                   LK-GLOBAL-STATE
                       BY WS-STATE

                   LK-TRANSITION-EVENT
                       BY WS-EVENT.

           01 WS-BUFFER            PIC X(100)
               VALUE "NOT TYPE-A TYPE-B TYPE-A".

           01 WS-PTR               PIC 9(03)
               VALUE 1.

           01 WS-TID               PIC 9(02).

           01 WS-EOS               PIC 9
               VALUE 0.

       PROCEDURE DIVISION.

      *    System initialization

           MOVE 1
               TO ST-POLARITY OF WS-STATE.

           MOVE 0
               TO ST-SCORE-INT OF WS-STATE.

           MOVE ALL '0'
               TO ST-FLAG-BITS OF WS-STATE.

           MOVE 0
               TO LK-EVENT-SEQ OF WS-HDR.

      *    Main deterministic event loop

           PERFORM UNTIL WS-EOS = 1

               CALL "PARSER-UNIT"
                   USING WS-BUFFER
                         WS-PTR
                         WS-TID
                         WS-EOS

               END-CALL

               IF WS-EOS = 0
                  AND WS-TID > 0
                  AND WS-TID < 99

                   ADD 1
                       TO LK-EVENT-SEQ OF WS-HDR

                   CALL "CORE-VM"
                       USING WS-TID
                             WS-STATE
                             WS-EVENT

                   END-CALL

      *            Transition routing / audit logging

                   CALL "EVENT-LOGGER"
                       USING WS-HDR
                             WS-EVENT

                   END-CALL

               END-IF

           END-PERFORM.

           DISPLAY
               "FINAL CALC SCORE: "
               ST-SCORE-INT OF WS-STATE.

           STOP RUN.
