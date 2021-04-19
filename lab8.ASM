LJMP INIT 			;skok do etykiety INIT
ORG 001BH 			;adres obslugi przerwania od T1
LJMP IRQT1 			;skok do procedury przerwania od T1
ORG 50H				;kolejne instrukcje od adresu 50H

INIT:				;inicjalizacja sprzetu

	MOV TH1, #0B1H		;ustawienie wartosci startowej liczniak T1
	MOV TL1, #0DFH		
	MOV TMOD, #00000000B	;ustawienie TMOD
	MOV TCON, #01000000B 	;ustawienie TCON, praca T1
	MOV IE, #10001000B 	;ustawienie obslugi przerwan, od licznika T1
	LJMP START		;skok do etykiety start
	
ORG 100H			;kolejne instrukcje od 100H
START: 				;start
	INC R1 			;inkremetnacja R1
	LJMP START 		;skok do start, petla glowna
	
ORG 150H			;kolejne instrukcje od 150H
IRQT1:				;procedura przewania od T1
	MOV P1,#11111110B 	;P1, zerowanie najmnniej znaczacej kolumny
	MOV 40H,P2		;wpisanie wartosci z portu P2 do komorki 40H 		
	
	MOV P1,#11111101B	;P1, zerowanie drugiej kolumny
	MOV 41H,P2 		;wpisanie wartosci z portu P2 do komorki 41H 	
 	
	MOV P1,#11111011B 	;P1, zerowanie trzeciej kolumny
	MOV 42H,P2 		;wpisanie wartosci z portu P2 do komorki 42H 	
 	
	MOV P1,#11110111B 	;P1, zerowanie ostatniej znaczacej kolumny
	MOV 43H,P2 		;wpisanie wartosci z portu P2 do komorki 43H 	
	
	RETI			;powrot z procedury
KONIEC: LJMP KONIEC	
END