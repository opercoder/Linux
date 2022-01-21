#!/bin/bash

FILE="01-30.dump"
OBJECT="15683"
RESULT="result.txt"

# Функция получения данных из общего дампа по заданной таблице
# Аргументы:
# 1: Имя таблицы
# 2: Объект, по которому идет фильтрация
# 3: 1 или 0, 1 - для загрузки в БД (с хедером), 0 - для цикла (без хедера) 
get_data () {
	local TABLE_NAME=$1
	local OBJECT_NAME=$2
	local FLAG=$3
	local HEADER=`cat $FILE | grep -m1 "COPY \"$TABLE_NAME\""`
	### Отрезаем лишнее до и после вхождения таблицы
	local N1=`cat $FILE | grep -n -m1 "COPY \"$TABLE_NAME\"" | cut -d: -f1`
	local N2=`cat $FILE | awk -v var="$N1" 'NR > var' | awk '/^\\\./{ print NR; exit }'`
	let N2=N1+N2-1
	if [ $FLAG -ne 0 ]; then echo "$HEADER"; fi
	### Записываем вхождение заданного объекта в файл
	sed -n ''$N1','$N2'p;'$N2'q' $FILE | grep "	$OBJECT_NAME	"
	if [ $FLAG -ne 0 ]; then echo "\\."; fi
}

# Таблица TASK_TARG
get_data TASK_TARG $OBJECT 0 > tmp1

###############################################################
# Читаем файл и запускаем цикл по TARG_ID и находим TASK_ID
# По найденным TASK_ID выгружаем данные из SEANCE_INFO
# По найденным TASK_ID выгружаем данные из PGO_ROUGH
# По найденным TASK_ID выгружаем данные из PGO_SUMMARY
# По найденным TASK_ID выгружаем данные из PGO_SUMMARY_LINK
###############################################################
while read line1; do
	echo "****************************"
	TARG_ID=`echo "$line1" | awk '{print $1}'`

	echo targ_id=$TARG_ID
	# Таблица TASK
	get_data TASK $TARG_ID 0 > tmp2
	while read line2; do
		TASK_ID=`echo "$line2" | awk '{print $1}'`
		echo "	task_id=$TASK_ID"
		get_data SEANCE_INFO $TASK_ID 1 > "taskid_$TASK_ID.tmp"
		get_data PGO_ROUGH $TASK_ID 1 > "pgo_rough_taskid_$TASK_ID.tmp"
		get_data PGO_SUMMARY $TARG_ID 1 > "pgo_summary_targid_$TASK_ID.tmp"
		get_data PGO_SUMMARY_LINK $TASK_ID 1 > "pgo_sum_link_taskid_$TASK_ID.tmp"
	done < tmp2
done < tmp1
echo "****************************"
rm tmp1 tmp2
