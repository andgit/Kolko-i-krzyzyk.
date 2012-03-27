function pokaz_macierz
{
	nowy_wiersz=0
	temp=0;
	echo " ___"
	echo -n "|"
	
	for i in `seq 0 8`;
	do
		let "temp = $i"
		let "temp %= 3"
		
		if [[ $temp = 0 && "$i" -gt 0 ]]; then
			echo -n "|"
			echo 
		fi
		
		if [[ $i = 3 || "$i" = 6 ]] ; then
			echo -n "|"
		fi
		
		echo -n ${tablica[$i]}
	done
	echo "|"
	echo
}

