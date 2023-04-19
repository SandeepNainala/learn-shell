
input=$1
if [ -z "$input"];
then
  echo Input Movie Name is missing
  exit
fi


percent=$(curl -s https://www.themoviedb.org/movie/$input1 | grep -w 70 | grep  user_score_chart
|xargs -n1 | awk -F = '{print $2}')

if [ "$percent -ge 70" ]; then
  echo Good
  else
    echo Average
fi