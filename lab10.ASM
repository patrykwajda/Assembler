LJMP INIT			;skok do etykiety INIT
	ORG 23H
LJMP RS				;skok do etykiety RS-przerwanie od p. szeregowego
	ORG 50H
INIT:				;etykieta INIT
	MOV SCON,#01010000B	;aktywowanie trtrybu pracy i portu szeregowego (01-bity SM0 i SM1)
				;wyzerowanie znacznika maskowania odbioru transmisji (bit SM2)
				;konfiguracja licznika T2
	MOV 0CBH,#0FFH		;ustawienie wartosci rejestru RCAP2H licznika T2
	MOV 0CAH,#0DCH 		;ustawienie wartosci rejestru RCAP2L licznika T2
	MOV 0C8H,#00110000B	;ustawienie bitow RCLK i TCLK aby licznik T2 sluzul do taktowania portu szeregowego
				;konfiguracja kontrolera przerwan
	SETB EA			;wlaczenie obslugi przerwan
	SETB ES			;uaktywnienie obslugi przerwan od portu szeregowego

	SETB 0C8H.2		;uruchomienie licznika T2 przez ustawienie bitu TR2
	MOV R0,#40H		
	MOV R1,#40H		;ustawienie poczatkowej wartosci rejestrow uzywanych do transmisji
LJMP PG				;skok do petli nieskonczonej
	ORG 150H
PG:				;etykieta PG
	INC R2			;inkrementacja rejestru R2
	CJNE R0,#50H,PG		;sprawdzenie czy odebrano wystarczajaca ilosc znakow do rozpoczenia przesylania
	CALL PROCNAD		;jesli odebrano wystarczajaca ilosc znakow, to skok do procedury nadajacej
LJMP PG
				;procedura obslugi przerwania od portu szeregowego
	ORG 250H
RS:
	JB TI,KONIEC		;jesli przepisywanie z portu to kontynuuj procedure nadawania
	JB RI,CALLPROCODB	;jesli wpisywanie do portu to skok do procedury odbierania
LJMP KONIEC
	CALLPROCODB:		;etykieta CALLPROCODB
	CALL PROCODB		;wywolanie procedury odbierania
LJMP KONIEC
KONIEC:				;etykieta KONIEC
	CLR RI			;wyzerowanie znacznikow
	CLR RI
	RETI			;powrot do wykonywania programu sprzed przerwania od portu szeregowego

	ORG 350H		
PROCNAD:
	CJNE R1,#50H,NADAWANIE	;jesli nie nadano jeszcze wszystkich znakow to kontynuuj nadawanie
LJMP KONIECNAD			;jesli nadano wszystkie znaki to skoncz procedure nadawania
NADAWANIE:
	MOV A,@R1
	MOV SBUF,A
	INC R1			;przepisywanie wartosci spod adresow 40-f4 do portu szeregowego
LJMP PROCNAD			;skok do sprawdzenia czy nadano juz wszystkie znaki
KONIECNAD:
	MOV R1,#40H
	MOV R0,#40H		;powrot do programu glownego po nadaniu wszystkich znakow i przygotowanie rejestrow
	RET			;do transnisji kolejnych znakow
	
	ORG 450H
PROCODB:
	MOV A,SBUF
	MOV @R0,A
	INC R0
	RET			;pojedyncze przepisywanie znakow wpisanych do rejestru, do pamieci wewnetrznej
END