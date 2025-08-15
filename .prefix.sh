#!/bin/bash

argc=$# #quantidade de argumentos passados
arg_quant=$(($argc-1)) #quantidade de arquivos a serem prefixados
array_args=("$@") #array dos argumentos
last_arg="${array_args[-1]}" #ultimo argumento do array
count=0 #iterador dos arquivos passados

if [ $argc -lt 2 ]; then
	echo "Quantidade de Argumentos inválido!"
	exit 1
fi


if [ $argc -gt 2 ]; then
	while [ $count -lt $arg_quant ]; do
		name_archive="${array_args[$count]}"
		prefix="$last_arg"

		if [[ "$name_archive" == "$prefix"* ]]; then
			echo "Arquivo '$name_archive' já possui este prefixo. Pulando..."
			((count++))
			continue
		fi

		if [ -e "$prefix$name_archive" ]; then
			echo "Este arquivo $prefix$name_archive já existe. Pulando..."
			((count++))
			continue
		fi

		mv "$name_archive" "$prefix$name_archive"
		((count++))
	done
else
	name_archive=$1
	prefix=$2
	
	if [[ "$name_archive" == "$prefix"* ]]; then
		echo "O arquivo '$name_archive' já possui este prefixo. Nao prefixado."
		exit 1
	fi

	if [ -e "$prefix$name_archive" ]; then
                        echo "Este arquivo $prefix$name_archive já existe. Nao prefixado."
                        exit 1
	 fi

	mv "$name_archive"  "$prefix$name_archive"
fi




