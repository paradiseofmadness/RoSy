            .text                   // Programm ins text segment
            .globl programm1        // "programm1" extern sichtbar
programm1:  SUBI SP, SP, #8         // stack frame anlegen
            STUR LR, [SP, #0]       // Rücksprungadresse retten
            LDUR XS0, x             // XS0 = x
            LDUR XS1, div           // XS1 = div
            BL loop                 // ruft die Schleife auf
            STUR XS0, x             // schreibt das neue x zurück
            LDUR LR, [SP, #0]       // Rücksprungadresse restaurieren
            ADDI SP, SP, #8         // stack frame löschen
            BR LR                   // Rücksprung
                                    
loop:       CMP XS0, XS1            
            B.LT ende               // Abbruch bei XS0 < XS1 (x < div)
            SUB XS0, XS0, XS1       // XS0 -= XS1 (x -= div)
            B loop                  // zurück zum Schleifenanfang
                                    
ende:       BR LR                   // Rücksprung in "programm1"

            .data                   // Beginn Datensegment
            .align 3                // auf Doppelwort-Grenze ausrichten
x:          .doubleword 42
div:        .doubleword 5