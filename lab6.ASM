STAN SET 001H			;bit start/stop
TL2 SET 0CCH 			
TH2 SET 0CDH 			;zdefiniowanie zmiennych na bity
RCAP2L SET 0CAH 
RCAP2H SET 0CBH 
T2CON SET 0C8H 
T2MOD SET 0C9H

LJMP INIT 			;skok do INIT

	ORG 0003H		;przerwanie INT0
LJMP IRQINT0			;jesli przerwanie INT0 to skok do tej procedury

	ORG 002BH 		;przerwanie T2
LJMP IRQT2 			;jesli przerwanie T2 to skok do tej procedury

	ORG 50H			;30H dla kolejnych instrukcji
INIT: 				;sprzet inicjalizacja
	MOV TH2, #0D8H 		;ustawienie licznika T2
	MOV TL2, #0F0H 		
	MOV RCAP2H, #0D8H	;ustawienie przeladowania licznika
	MOV RCAP2L, #0F0H 	
	MOV IE, #10100001B 	;ustawienie bitow przerwan od T2 i INT0
	MOV TCON, #00000101B 	;przerwanie od zbocza opadajacego
	MOV T2CON, #00000100B	;ustawienie licznika T2
	LJMP START

	ORG 100H		;100H dla kolejnych instrukcji
START: 				;start
	INC R7 			;inkrementacja R7
	LJMP START 		;skok do start

	ORG 150H		;150H dla kolejnych instrukcji
IRQT2: 				;procedura przerwania od T2
	INC DPTR 		;inkrementacja dptr
	RETI			;powrot
	
	ORG 200H		;200H dla kolejnych instrukcji
IRQINT0:			;procedura przerwania od INT0
	JB 20H, SSTOP 		;skok do etykiety sstop gdy bit jest ustawiony
	MOV 51H, DPL		;zapisanie rozpoczecia liczenia stopera
	MOV 52H, TH2
	MOV 53H, TL2
	CPL 20H 		;negacja bitu 20h
	LJMP ENDINT0 		;skok do przerwania INT0
	
ENDINT0:
	RETI			;powrot

	ORG 250H
SSTOP:				;bit 20h = 1
	MOV 60H, DPH 		;zapisanie czasu w momencie zatrzymania
	MOV 61H, DPL
	MOV 62H, TH2		
	MOV 63H, TL2
	MOV A, 63H 		;wyznaczenie czasu ktory uplynal od startu do zatrzymania zliczania 
	SUBB A, 53H 		
	MOV 73H, A 		
	MOV A, 62H 				
	SUBB A, 52H
	MOV 72H, A
	MOV A, 61H
	SUBB A, 51H
	MOV 71H, A
	MOV A, 60H
	SUBB A, 50H
	MOV 70H, A 		;przeniesienie wartosci obliczen do komorki 70H
	CLR 20H 		;wyzerowanie bitu 20h
	
KONIEC: LJMP KONIEC
END