TH2 SET 0CDH			;przypisanie nazwy do adresu mniej znaczacego bajtu T2
TL2 SET 0CCH			;przypisanie nazwy do adresu bardziej znaczacego bajtu T2
RCAP2H SET 0CBH			;przypisanie nazw do rejestrow przeladowania
RCAP2L SET 0CAH			;
T2CON SET 0C8H			;przypisanie nazwy do rejestru t2con licznika T2

LJMP INIT			;skok do etykiety INIT

ORG 0003H			;adres przerwania od INT0
LJMP IRQINT0			;skok do procedury przerwania od INT0

ORG 002BH			;adres przerwania od T2
LJMP IRQT2			;skok do procedury przerwania od T2

ORG 50H				;kolejne instrukcje w pamieci od 50H
INIT:				;inicjalizacja sprzetowa
MOV TMOD, #00000101B		;ustawienie TMOD, T0 tryb 1, C/T zliczanie krancowki
MOV TCON, #00010000B		;ustawienie TCON, praca licznika T0
MOV T2CON, #00000100B		;ustawienie T2CON, uruchamia zliczanie
MOV TL2, #10101111B		;ustawienie TL2, maks impulsy
MOV TH2, #00111100B		;ustawienie TH2
MOV IE, #10100001B		;ustawienie IE, konfirguracja przerwan od INT0,T2
MOV R7, #10D			;10D do R7

LJMP START			;skok do start

ORG 100H			;kolejne instrukcje od 100H
START:				;start, petla glowna
MOV P2, TH0			;przepisanie TH0 do P2
MOV A, TL0			;przepisanie TL0 do Acc
LJMP START			;skok do start

ORG 200H			;kolejne instrukcje od 200H
IRQINT0:			;procedura przerwania od INT0
MOV TH0, #0			;zerowanie TH0 i TL0
MOV TL0, #0
RETI				;powrot

ORG 300H			;kolejne instrukcje od 300H
IRQT2:				;przerwanie od T2
DJNZ R7, END_T2			;jesli R7 rozne od 0 to skok pod END_T2 - ominiecie intrukcji
MOV R7, #10D			;10D do R7
CPL P1.0			;negacja P1.0
END_T2:				;etykieta
RETI				;powrot

KONIEC: LJMP KONIEC
END