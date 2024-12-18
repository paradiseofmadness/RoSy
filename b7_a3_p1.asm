            .text                   // Programm ins text segment
            .globl programm1        // "programm1" extern sichtbar
programm1:  SUBI SP, SP, #8         // stack frame anlegen
            STUR LR, [SP, #0]       // Rücksprungadresse retten
            LDUR A0, x             // A0 = x
            LDUR A1, div           // A1 = div
            BL loop                 // ruft die Schleife auf
            STUR A0, x             // schreibt das neue x zurück
            LDUR LR, [SP, #0]       // Rücksprungadresse restaurieren
            ADDI SP, SP, #8         // stack frame löschen
            BR LR                   // Rücksprung
                                    
loop:       CMP A0, A1            
            B.LT ende               // Abbruch bei A0 < A1 (x < div)
            SUB A0, A0, A1       // A0 -= A1 (x -= div)
            B loop                  // zurück zum Schleifenanfang
                                    
ende:       BR LR                   // Rücksprung in "programm1"

            .data                   // Beginn Datensegment
            .align 3                // auf Doppelwort-Grenze ausrichten
x:          .doubleword 42
div:        .doubleword 5
