LJMP  INIT	;skok do etykiety inicjalizujacej sprzet	
ORG 000BH	;adres przerwania od licznika T0
LJMP IRQT0	;skok do etykiety procedury przerwania od T0
ORG 001BH	;adres przerwania od licznika T1
LJMP IRQT1	;skok do etykiety procedury przerwania od T1


	ORG 50H		;adres 50H dla kolejnego kodu
INIT:			
	MOV TMOD,#00100010B	;konfiguracja licznikow T0 i T1
	MOV TCON,#01010000B	;konfiguracja licznikow T0 i T1
	MOV IE,#10001010B	;konfiguracja kontrolera przerwan, ustawienie bitow EA i ET1, ET0
	MOV TH1,#0F5H		;zmiana czestotliwosci zliczania licznikow T1 i T0
	MOV TL1,#0F5H
	MOV TH0,#5AH
	MOV TL0,#5AH
	MOV R1, #100D		;stala 100D do R1
	MOV R2, #100D		;stala 100D do R2
	
LJMP START	;skok do etykiety start
ORG 100H	;adres pamieci od 100H dla nastepnego kodu
START:		;etykieta start
INC R7		;inkrementacja R7
LJMP START	;skok do start

ORG 200H	;adres w pamieci 200H dla kodu proceudry od przerwania T0
IRQT0:		;etykieta procedury od przerwania T0
INC R2		;inkrementacja R2
RETI		;koniec procedury

ORG 300H	;adres w pamieci 200H dla kodu proceudry od przerwania T0
IRQT1:		;etykieta procedury od przerwania T0
DEC R1		;dekrementacja R1
RETI		;koniec procedury

KONIEC: LJMP KONIEC
END


