            .text                   // Programm ins text segment
            .globl programm2        // "programm2" extern sichtbar
programm2:  SUBI SP, SP, #8         // stack frame anlegen
            STUR LR, [SP, #0]       // Rücksprungadresse retten
            LDUR A0, input         // A0 = input
            LDUR A1, pin           // A1 = pin
            ADD A2, XZR, XZR       // A2 =  trail = 0
            BL loop                 // ruft die Schleife auf
            LDUR LR, [SP, #0]       // Rücksprungadresse restaurieren
            ADDI SP, SP, #8         // stack frame löschen
            BR LR                   // Rücksprung

loop:       ADDI A0, A0, #10      // Erhöht A0 / input um 10
            ADDI A2, A2, #1       // Erhöht A2 / trail um 1
            CMP A0, A1
            B.EQ ende               // Abbruch wenn A0 == A1 (input == pin)
            CMP A2, #4
            b.EQ ende               // Abbruch wenn A2 == 4 (trail == 4)
            B loop                  // Zurück zum Schleifenbeginn (wenn input!=pin && trial!=4)

ende:       BR LR                   // Rücksprung in "programm2" 

            .data                   // Beginn Datensegment
            .align 3                // auf Doppelwort-Grenze ausrichten
input:      .doubleword 1200
pin:        .doubleword 1234
