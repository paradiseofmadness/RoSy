            .text                   // Programm ins text segment
            .globl programm2        // "programm2" extern sichtbar
programm2:  SUBI SP, SP, #8         // stack frame anlegen
            STUR LR, [SP, #0]       // Rücksprungadresse retten
            LDUR XS0, input         // XS0 = input
            LDUR XS1, pin           // XS1 = pin
            ADD XS2, XZR, XZR       // XS2 =  trail = 0
            BL loop                 // ruft die Schleife auf
            LDUR LR, [SP, #0]       // Rücksprungadresse restaurieren
            ADDI SP, SP, #8         // stack frame löschen
            BR LR                   // Rücksprung

loop:       ADDI XS0, XS0, #10      // Erhöht XS0 / input um 10
            ADDI XS2, XS2, #1       // Erhöht XS2 / trail um 1
            CMP XS0, XS1
            B.EQ ende               // Abbruch wenn XS0 == XS1 (input == pin)
            CMP XS2, #4
            b.EQ ende               // Abbruch wenn XS2 == 4 (trail == 4)
            B loop                  // Zurück zum Schleifenbeginn (wenn input!=pin && trial!=4)

ende:       BR LR                   // Rücksprung in "programm2" 

            .data                   // Beginn Datensegment
            .align 3                // auf Doppelwort-Grenze ausrichten
input:      .doubleword 1200
pin:        .doubleword 1234