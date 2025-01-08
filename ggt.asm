            .text                   // Programm ins text segment
            .globl main             // "main" extern sichtbar
main:       SUBI SP, SP, #8         // stack frame anlegen
            STUR LR, [SP, #0]       // Rücksprungadresse retten
            LDUR A0, a              // A0 = a = x
            LDUR A1, b              // A1 = b = y
            BL ggt                  // ruft ggt(x, y) auf
            STUR A0, erg            // schreibt ggt(x, y) nach erg zurück
            LDUR LR, [SP, #0]       // Rücksprungadresse restaurieren
            ADDI SP, SP, #8         // stack frame löschen
            BR LR                   // Rücksprung
                                    
ggt:        CMP A0, A1
        	B.EQ ende               // Abbruch, wenn x == y
            B.GT nlt
            SUB A1, A1, A0          // y -= x (wenn x < y)
            B ggt
nlt:        SUB A0, A0, A1          // x -= y (wenn y < x)
            B ggt
                                    
ende:       BR LR                   // Rücksprung in "main" (x in A0)

            .data                   // Beginn Datensegment
            .align 3                // auf Doppelwort-Grenze ausrichten
a:          .doubleword 100
b:          .doubleword 35
erg:        .doubleword 0
