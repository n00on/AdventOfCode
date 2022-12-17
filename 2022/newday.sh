#/bin/bash
mkdir $1;
cd $1;
echo "with open(\"input.txt\") as f:" > day$1.py;
touch "input.txt";