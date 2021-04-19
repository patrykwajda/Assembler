MOV SP,#20H		;ustawienie wierzcholka stosu na adres 20H
LJMP START		;skok do start
ORG 100H		;ustawienie pamieci na program od komorki 100H
START:			;etykieta start

	MOV A,#55H	;wpisanie do akumulatora stalej
	MOV DPTR,#44H	;wpisanie do DPTR stalej
	MOV 50H,#60H	;wpisanie do komorki o adresie 50H stalej
	MOV 51H,#61H	;wpisanie do komorki o adresie 51H stalej
	MOV R1,50H	;przepisanie wartosci z komorki 50H do R1 w banku 0
	MOV R2,51H	;przepisanie wartosci z komorki 51H do R2 w banku 0
	
	CALL PROCEDURA	;wywolanie procedury
	
	LJMP START	;skok do start
	ORG 200H	;ustawienie zapisania procedury od komorki 200H w ROM
PROCEDURA:
	PUSH ACC	;wpisanie na stos akumulatora
	PUSH DPH	;wpisanie na stos DPH
	PUSH DPL	;wpisanie na stos DPL
	PUSH B		;wpisanie na stos B
	PUSH PSW	;wpisanie na stos PSW
	
	SETB PSW.3	;ustawienie bitu RS0, -> przelaczenie na bank1
	
	MOV R1,50H	;przepisanie wartosci komorki 50H do rejestru R1 w banku 1
	MOV R2,51H	;przepisanie wartosci komorki 51H do rejestru R2 w banku 1
	
	MOV A,R1	;przepisanie wartosci rejestru R1 bank 1 do A
	CPL A		;negacja bitow A
	MOV R3,A	;przepisanie A do R3 bank 1
	MOV A,R2	;przepisanie R2 do A
	CPL A		;negacja bitow A
	MOV R4,A	;przeniesienie A do R4 bank 1
	
	CLR PSW.3	;wyzerowanie bitu RSO
	SETB PSW.4	;bank 2
	
	MOV A,50H	;przepisanie komorki 50H do A
	MOV B,51H	;przepisanie komorki 51H do B
	MUL AB		;mnozenie A i B
	MOV R1,A	;przepisanie mlodszego bitu wyniku do R1 bank 2
	MOV R2,B	;przepisanie starszego bitu wyniku do R2 bank 2
	
	CLR PSW.3	;wyzerowanie bitu RSO, bank 0
	CLR PSW.4	;wyzerowanie bitu RSO, bank 0
	
	POP ACC		;zdjecie ze stosu PSW
	POP DPH	;zdjecie ze stosu DPH
	POP DPL	;zdjecie ze stosu DPL
	POP B		;przed powrotem z procedury nalezy zdjac ze stosu to co na niego polozylismy w trakcie jej trwania
	POP PSW		;zdjecie ze stosu PSW
	RET		;adres powrotny pobierany jest ze stosu, powrot do miejsca wywolania procedury
KONIEC: LJMP KONIEC
END