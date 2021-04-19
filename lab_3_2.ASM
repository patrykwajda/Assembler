AL SET 51H		;Zdefiniowanie zmiennej AL pod adresem 50H - pierwszy argument sumowania, mlodszy bajt
AH SET 50H		;Zdefiniowanie zmiennej AH pod adresem 50H - pierwszy argument sumowania, starszy bajt
BL SET 53H		;Zdefiniowanie zmiennej BL pod adresem 51H - drugi argument sumowania, mlodszy bajt
BH SET 52H		;Zdefiniowanie zmiennej BH pod adresem 50H - pierwszy argument sumowania, starszy bajt
CL SET 56H		;Zdefiniowanie zmiennej CL pod adresem 52H - wynik sumowania, najmlodszy bajt
CH SET 55H		;Zdefiniowanie zmiennej CH pod adresem 53H - wynik sumowania, posredni bajt
CH2 SET 54H		;Zdefiniowanie zmiennej CH2 pod adresem 50H - pierwszy argument sumowania, najstarszy bajt

	LJMP START	;skok do START
	
	ORG 100H	;dyrektywa ktora umieszcza ponizszy kod programu w adresie pamieci zaczynajacym sie od 100H
START:			;etykieta START
	MOV AL,#0F1H	;Przypisanie wartosci pierwszemu argumentowi, mlodszy bajt
	MOV AH,#0F5H	;Przypisanie wartosci pierwszemu argumentowi, starszy bajt
	MOV BL,#44H	;Przypisanie wartosci drugiemu argumentowi, nlodszy
	MOV BH,#34H	;Przypisanie wartosci drugiemu argumentowi, starszy bajt
	CALL SUMA	;Wywolanie procedury sumujacej
	LJMP START	;Powrót do poczatku petli glownej


			
	ORG 200H	;Dyrektywa - procedura zostanie umieszczona w komorce 200H
SUMA:			;Etykieta procedury SUMA
	MOV A,AL	;Przepisanie wartosci zmiennej AL do akumulatora
	MOV R1, BL	;Przepisanie wartosci zmiennej BL do rejestru uniwersalnego R1
	ADD A,R1	;Wyliczenie sumy A + R1
	MOV CL,A	;Wpisanie wyniku 1 sumowania mlodszych bajtow do zmiennej CL
	MOV A,AH	;Przepisanie wartosci zmiennej AH do akumulatora
	MOV R1,BH	;Przepisanie wartosci zmiennej BH do rejestru R1
	ADDC A,R1	;dodawanie z przeniesieniem, wartosc akumulatora + rejestru R1 (AH + BH)
	MOV CH,A	;Przeniesienie zsumowanej wartosci z akumulatora do starszego bitu CH
	MOV A,#0	;Wyzerowanie akumulatora
	ADDC A,#0	;Dodawanie wartosci flagi przeniesienia do akumulatora
	MOV CH2,A	;zapisanie wartosci przeniesienia do najstarszego bitu CH2
	
	RET		;Powrot do programu glownego
	
END			;koniec programu glownego