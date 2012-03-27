#!/bin/bash

. pokaz_macierz.sh		#funkcja pokazujaca macierz kolko i krzyzyk

lw=3	#liczba_wierszy
lk=3	#liczba_kolumn
koniec_gry=0

tablica=(0 0 0 
	 0 0 0 
	 0 0 0)

echo 
echo [ Witaj w grze kółko '&' krzyzyk ]
echo

gracz=$[ ( $RANDOM % 2 )  + 1 ]

if [ $gracz = 1 ]; then
	echo Zaczyna gracz 1.
else
	echo Zaczyna gracz 2.
fi

czy_koniec_gry=0	#zmienna potrzebna do zakonczenia gry gdy nikt z graczy nie skreli odpowiednio 3 pol
skosna_l=0
skosna_p=0

while [ $koniec_gry = 0 ]; do

	if [ $czy_koniec_gry -le 8 ]; then #czy strzalow bylo mniej niz 9 zaczynajac od 0

		poprawne=0

		while [ $poprawne = 0 ]; do
		
			if [ $gracz = 1 ]; then
				echo Gracz '(1)' Podaj pole [1-3][1-3]
			else
				echo Gracz '(2)' Podaj pole [1-3][1-3]
			fi

			read wrr
			let wr=wrr-1

			read kll
			let kl=kll-1

			let strzal=(lk*wr)+kl
			
			if [[ $strzal -ge 0 && "$strzal" -le 8 ]]; then		#czy podales prawidlowe wspolrzedne [1-3][1-3]
			
				if [ ${tablica[$strzal]} = 0 ]; then
					if [ $gracz = 1 ]; then
						tablica[strzal]=1
						let gracz=2
					else
						tablica[strzal]=2
						let gracz=1
					fi
					let poprawne=1
				else
					echo To pole jest juz zaznaczone
				fi
			else
				echo Podales zle wspolrzedne
			fi
		done
		
		pokaz_macierz
			##########################################################sprawdzanie skreslen
			pomocnicza_l=0
			pomocnicza_p=0
			
			for i in `seq 0 8`; do
			
				if [[ ${tablica[$i]} = 1 || "${tablica[$i]}" = 2 ]]; then
					###########################!na skos backslash!#################################
					if [ $i = 0 ]; then
						pomocnicza_l=${tablica[$i]}
						
						if [ ${tablica[$i+4]} = $pomocnicza_l ] && [ ${tablica[$i+8]} = $pomocnicza_l ]; then
							echo Koniec gry.
							
							if [ $pomocnicza_l = 1 ]; then
								echo Wygral gracz 1.
							else
								echo Wygral gracz 2.
							fi
							
							let koniec_gry=1
							let czy_koniec_gry=9;
							break;
						fi
						let pomocnicza_l=0
					fi
					###########################!na skos slash!#################################
					if [ $i = 2 ]; then
						pomocnicza_p=${tablica[$i]}
						
						if [ ${tablica[$i+2]} = $pomocnicza_p ] && [ ${tablica[$i+4]} = $pomocnicza_p ]; then
							echo Koniec gry.
							
							if [ $pomocnicza_p = 1 ]; then
								echo Wygral gracz 1.
							else
								echo Wygral gracz 2.
							fi
							
							let koniec_gry=1
							let czy_koniec_gry=9;
							break;
						fi
						let pomocnicza_p=0
					fi					
					########################!wiersze!####################################
					if [ $i = 0 ] || [ $i = 3 ] || [ $i = 6 ]; then
						pomocnicza_w=${tablica[$i]}
						
						if [ ${tablica[$i+1]} = $pomocnicza_w ] && [ ${tablica[$i+2]} = $pomocnicza_w ]; then
							echo Koniec gry.
							
							if [ $pomocnicza_w = 1 ]; then
								echo Wygral gracz 1.
							else
								echo Wygral gracz 2.
							fi
							
							let koniec_gry=1
							let czy_koniec_gry=9;
							break;
						fi
						let pomocnicza_w=0
					fi
					########################!kolumny!####################################
					if [ $i = 0 ] || [ $i = 1 ] || [ $i = 2 ]; then
						pomocnicza_k=${tablica[$i]}
						
						if [ ${tablica[$i+3]} = $pomocnicza_k ] && [ ${tablica[$i+6]} = $pomocnicza_k ]; then
							echo Koniec gry.
							
							if [ $pomocnicza_w = 1 ]; then
								echo Wygral gracz 1.
							else
								echo Wygral gracz 2.
							fi
							
							let koniec_gry=1
							let czy_koniec_gry=9;
							break;
						fi
						let pomocnicza_k=0						
					fi
				fi
			done
			
			let "skosna_l=0"
			let "skosna_p=0"
			##########################################################

		let czy_koniec_gry=czy_koniec_gry+1;
	else
		echo Koniec gry. Remis.
		let koniec_gry=1;
	fi
done

exit

