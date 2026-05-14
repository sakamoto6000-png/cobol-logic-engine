       IDENTIFICATION DIVISION.
       PROGRAM-ID. EVENT-LOGGER.

      *---------------------------------------------------------------*
      * PROJECT   : COBOL Logic Engine: The Immutable Core
      * ARCHITECT : Takanori Sakamoto
      * FUNCTION  : Transition Event Audit Logger
      *---------------------------------------------------------------*

       DATA DIVISION.

       LINKAGE SECTION.

           COPY "PROTOCOL.cpy".

       PROCEDURE DIVISION USING LK-PROTOCOL-HEADER
                                LK-TRANSITION-EVENT.

      *    Deterministic transition log output

           DISPLAY
               "[SEQ:"
               LK-EVENT-SEQ
               "] TID="
               RES-TID
               " OPCODE="
               RES-OPCODE
               " DELTA="
               RES-DELTA
               " STATUS="
               RES-STATUS.

           EXIT PROGRAM.
