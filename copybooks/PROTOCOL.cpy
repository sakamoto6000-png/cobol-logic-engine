      *---------------------------------------------------------------*
      * PROJECT   : COBOL Logic Engine: The Immutable Core
      * ARCHITECT : Takanori Sakamoto
      * VERSION   : 1.0.0 (2026-05-14)
      * STATUS    : Deterministic / Pure-Logic / Agnostic
      *---------------------------------------------------------------*

       01 LK-PROTOCOL-HEADER.

           05 LK-PROT-VER          PIC 9(04)
               VALUE 1000.

           05 LK-EVENT-SEQ         PIC 9(18).

           05 LK-DOMAIN-ID         PIC 9(02).

      *---------------------------------------------------------------*
      * GLOBAL STATE
      *---------------------------------------------------------------*

       01 LK-GLOBAL-STATE.

           05 ST-POLARITY          PIC S9(01).

           05 ST-SCORE-INT         PIC S9(07)
               COMP-3.

           05 ST-FLAG-BITS         PIC X(64).

      *---------------------------------------------------------------*
      * TRANSITION EVENT
      *---------------------------------------------------------------*

       01 LK-TRANSITION-EVENT.

           05 RES-TID              PIC 9(02).

           05 RES-OPCODE           PIC 9(02).

           05 RES-DELTA            PIC S9(04)
               COMP-3.

           05 RES-STATUS           PIC X(01).
