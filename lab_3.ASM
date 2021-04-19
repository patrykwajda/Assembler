AL SET 50H		;Zdefiniowanie zmiennej AL pod adresem 50H - pierwszy argument sumowania
AH SET 51H
BL SET 52H		;Zdefiniowanie zmiennej BL pod adresem 51H - drugi argument sumowania
BH SET 53H
CL SET 54H		;Zdefiniowanie zmiennej CL pod adresem 52H - wynik sumowania
CH SET 55H
CL2 SET 56H		;Zdefiniowanie zmiennej CL2 pod adresem 53H - wynik sumowania
CH2 SET 57H

	LJMP START
	
	ORG 100H
START:
	MOV AL,#10	;Przypisanie wartosci pierwszemu argumentowi
	MOV BL,#12	;Przypisanie wartosci drugiemu argumentowi
	CALL SUMA	;Wywolanie procedury sumujacej
	MOV AL, P0	;Ponowne przypisanie wartosci pierwszemu argumentowi
	MOV BL, P1	;Ponowne przypisanie wartosci drugiemu argumentowi
	CALL SUMA	;Ponowne wywolanie sumowania dla nowych wartosci
	MOV A,CL	;
	MOV CL2,A	;Przepisanie wyniku sumowania do CL2 - komorka pamieci 53H
	LJMP START	;Powrót do poczatku petli glownej


			;Procedura z dwoma argumentami wejsciowymi AL,BL i jednym wyjsciowym CL
	ORG 200H	;Dyrektywa - procedura zostanie umieszczona w komorce 200H
SUMA:			;Etykieta procedury
	MOV A,AL	;Przepisanie wartosci zmiennej AL do akumulatora
	MOV R1, BL	;Przepisanie wartosci zmiennej BL do rejestru uniwersalnego R1
	ADD A,R1	;Wyliczenie sumy A + R1
	MOV CL,A	;Wpisanie wyniku sumowania do zmiennej CL
	
	RET		;Powrot do programu glownego
	
END			;koniec programu glownego