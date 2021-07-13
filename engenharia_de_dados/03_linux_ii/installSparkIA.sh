#!/bin/bash

echo """
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
| Instalador do Apache Spark3 (Scala, PySpark)                               |
| Desenvolvido por Romerito Morais                                           |      
| Data de Criação: 11/07/2021                                                |
| Obs:: script testado no fedora32+, centos8+, ubuntu20.04+ e linuxmint30.1+ |
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""

export DISTRO=$(cat /etc/os-release | head -3 | tail -1 | cut -d "=" -f 2)

Menu() {
echo '
Qual versão do Apache Spark desejas Instalar?
Opções:
     1)  spark-3.0.1-bin-hadoop3.2.tgz
     2)  spark-3.0.1-bin-hadoop2.7.tgz
     3)  spark-3.0.0-bin-hadoop3.2.tgz
     4)  spark-3.0.0-bin-hadoop2.7.tgz
     5)  spark-2.4.7-bin-hadoop2.7.tgz
     6)  spark-2.4.7-bin-hadoop2.6.tgz
     7)  spark-2.4.6-bin-hadoop2.7.tgz
     8)  sair
  '
  
  echo
  echo -n "código da opção:  "
  read OPCAO

if [ $OPCAO -eq 1 ]; then
    export SPARK="spark-3.0.1"
    export HADOOP="bin-hadoop3.2"
elif [ $OPCAO -eq 2 ]; then
    export SPARK="spark-3.0.1"
    export HADOOP="bin-hadoop2.7"
elif [ $OPCAO -eq 3 ]; then
    export SPARK="spark-3.0.0"
    export HADOOP="bin-hadoop3.2"
elif [ $OPCAO -eq 4 ]; then
    export SPARK="spark-3.0.0"
    export HADOOP="bin-hadoop2.7"
elif [ $OPCAO -eq 5 ]; then
    export SPARK="spark-2.4.7"
    export HADOOP="bin-hadoop2.7"
elif [ $OPCAO -eq 6 ]; then
    export SPARK="spark-2.4.6"
    export HADOOP="bin-hadoop2.6"
elif [ $OPCAO -eq 7 ]; then
    export SPARK="spark-2.4.6"
    export HADOOP="bin-hadoop2.7"
fi

case $OPCAO in
    8) exit ;;
  esac

}

Menu

DIR="$HOME/Documents"

if [ -e "$DIR" ];
then
export DOCUMENTS="$HOME/Documents"
else
export DOCUMENTS="$HOME/Documentos"
fi

JUPYTERICON="https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,c_fill,w_200,h_200/https://api.charmhub.io/api/v1/media/download/charm_q7WsJpwg08cLjb6nax37iHMKG8liuR1w_icon__fde574967418afe93bb032808563e40e63606adb805113065acfa35010332164.png"
SCALAICON="https://cdn.iconscout.com/icon/free/png-256/scala-226059.png"
ZIPSPARK="https://archive.apache.org/dist/spark/$SPARK/$SPARK-$HADOOP.tgz"
DADOSDEEXEMPLO="http://dados.df.gov.br/pt_BR/dataset/8569462f-8d8c-41de-a760-95058f8d4e3c/resource/e96d1ec5-446d-4c71-993a-d6ff7ea56cf8/download/visitantes-fjzb.csv"

rm -rf $DOCUMENTS/Spark3
rm -rf "$HOME/.local/share/applications/jupyter.desktop"
sudo rm -rf /usr/local/spark

mkdir -p $DOCUMENTS/Spark3/Install

echo """
######################################################################################################################################################################
Instalando Dependencias ...
"""

if [ $DISTRO = fedora ] || [ $DISTRO = centos ]; then
    sudo yum install python3-pip
    sudo yum remove jupyter-notebook -y
    sudo pip3 uninstall spylon-kernel -y
    sudo pip3 uninstall pyspark -y
    sudo pip3 uninstall jupyterlab -y
    sudo yum update -y
    sudo yum install java-11-openjdk-devel -y
    sudo yum install java-1.8.0-openjdk-devel -y
    sudo pip3 install --upgrade pip
    sudo pip3 install spylon-kernel
    sudo python3 -m spylon_kernel install
    sudo yum install jupyter-notebook -y
    sudo pip3 install jupyterlab
    sudo pip3 install pyspark
elif [ $DISTRO = ubuntu ] || [ $DISTRO = linuxmint ]; then
    sudo apt install python3-pip
    sudo apt remove jupyter-notebook -y
    sudo pip3 uninstall spylon-kernel -y
    sudo pip3 uninstall pyspark -y
    sudo pip3 uninstall jupyterlab -y
    sudo apt update -y
    sudo apt install default-jre -y
    sudo apt install openjdk-8-jdk -y    
    sudo pip3 install --upgrade pip
    sudo pip3 install spylon-kernel
    sudo python3 -m spylon_kernel install
    sudo pip3 install terminado --user --ignore-installed
    sudo apt install jupyter-notebook -y
    sudo pip3 install jupyterlab
    sudo pip3 install pyspark
fi

if [ $SPARK = spark-3.0.1 ]; then
     SPARK_VERSION="Spark 3.0.1"
elif [ $SPARK = spark-3.0.0 ]; then
     SPARK_VERSION="Spark 3.0.0"
elif [ $SPARK = spark-2.4.7 ]; then
     SPARK_VERSION="Spark 2.4.7"
elif [ $SPARK = spark-2.4.6 ]; then
     SPARK_VERSION="Spark 2.4.6"
fi

echo """
######################################################################################################################################################################
Baixando o $SPARK-$HADOOP ...
"""

wget -c -P $DOCUMENTS/Spark3/Install $JUPYTERICON
wget -c -P $DOCUMENTS/Spark3/Install $SCALAICON
wget -c -P $DOCUMENTS/Spark3/Install $ZIPSPARK
wget -c -P $DOCUMENTS/Spark3/Install $DADOSDEEXEMPLO

mv $DOCUMENTS/Spark3/Install/charm_q7WsJpwg08cLjb6nax37iHMKG8liuR1w_icon__fde574967418afe93bb032808563e40e63606adb805113065acfa35010332164.png $DOCUMENTS/Spark3/Install/jupyter.png
mv $DOCUMENTS/Spark3/Install/visitantes-fjzb.csv $DOCUMENTS/Spark3/Install/samples.csv
mv $DOCUMENTS/Spark3/Install/scala-226059.png $DOCUMENTS/Spark3/Install/logo-64x64.png && sudo cp $DOCUMENTS/Spark3/Install/logo-64x64.png /usr/local/share/jupyter/kernels/spylon-kernel/

echo """
######################################################################################################################################################################
Instalando o $SPARK-$HADOOP ...
"""

cd $DOCUMENTS/Spark3/Install
tar -xvf "$SPARK-$HADOOP.tgz"

mv $DOCUMENTS/Spark3/Install/$SPARK-$HADOOP  $DOCUMENTS/Spark3
sudo ln -s $DOCUMENTS/Spark3/$SPARK-$HADOOP/ /usr/local/spark

echo 'export SPARK_HOME=/usr/local/spark' >> ~/.bashrc
echo 'export PATH=$PATH:$SPARK_HOME/bin' >> ~/.bashrc
echo 'export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH' >> ~/.bashrc
echo 'export PYSPARK_PYTHON=python3' >> ~/.bashrc
source ~/.bashrc

touch  $DOCUMENTS/Spark3/README
cat << EOF > $DOCUMENTS/Spark3/README
Instalador Desenvolvido por Romerito Morais
https://www.linkedin.com/in/romeritomorais/
EOF

# modifica os dados do kernel spark/scala
cat << EOF > /tmp/kernel.json
{"argv": ["/usr/bin/python3", "-m", "spylon_kernel", "-f", "{connection_file}"], "display_name": "$SPARK_VERSION", "env": {"PYTHONUNBUFFERED": "1", "SPARK_SUBMIT_OPTS": "-Dscala.usejavacp=true"}, "language": "scala", "name": "spylon-kernel"}
EOF

sudo cp /tmp/kernel.json /usr/local/share/jupyter/kernels/spylon-kernel
sudo rm -rf /tmp/kernel.json

# cria arquivo .desktop icone de acesso ao programa
touch "$HOME/.local/share/applications/jupyter.desktop"

# abre o arquivo jupyter.desktop e define variáveis de configuração
cat << EOF > $HOME/.local/share/applications/jupyter.desktop
[Desktop Entry]
Name=Jupyter
Exec=jupyter-lab
Icon=$DOCUMENTS/Spark3/Install/jupyter.png
Type=Application
Categories=Development;
NoDisplay=false
EOF

sleep 5

JUPYTER_VERSION=$(jupyter-notebook --version)

echo """
######################################################################################################################################################################
$SPARK_VERSION($HADOOP) e jupyter Notebook $JUPYTER_VERSION instalados com sucesso. 
procure no seu menu de programas por jupyter

* Instalador Desenvolvido por Romerito Morais
* https://www.linkedin.com/in/romeritomorais/

"""
