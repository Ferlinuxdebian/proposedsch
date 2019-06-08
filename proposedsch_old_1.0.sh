#!/bin/bash

###############################################################
## Nome      : proposedsch                                   ##
## Autor     : Fernando Debian                               ##
## Descrição : Script para pesquisa pacotes proposed-updates ##
###############################################################

# Variaveis
mainlink="https://is.gd/packagesmain"
contriblink="https://is.gd/packagescontrib"
nonfreelink="https://is.gd/packagesnonfree"
errorfont="Sem fonte para pesquisa, proposedsch -u?"
notargument="Essa opção requer um argumento."

# Cria um diretório temporaŕio, para armazenar o downlaods do arquivos.
mkdir -p /tmp/packages 2>&-
cd /tmp/packages # acessa o local para trabalhar com arquivos.

#############################################
## Função que realiza downlaod de arquivos ##
## do repositório, para pesquisa local.    ##
#############################################
function packages {

  if wget -q -N $mainlink $contriblink $nonfreelink; then
     echo "Lista de pacotes obtido com sucesso!"
  else
     echo "Não foi possível obter a lista de pacotes."
  fi

} # Fim da Função.

########################################
## Função que mostra todos os pacotes ##
########################################
function all_packages {

   [ -e packagesmain -a -e packagescontrib -a -e packagesnonfree ] && \
   zcat /tmp/packages/packa* | grep '^Package:' | cut -d' ' -f2    || \
   echo $errorfont

} # Fim da Função.

#####################################
## Função para mostrar em valores, ##
## total de pacotes repositórioo.  ##
#####################################
function valorpackage {

   [ -e packagesmain -a -e packagescontrib -a -e packagesnonfree ] && \
   zcat /tmp/packages/packa* | grep '^Package:' | wc -l            || \
   echo $errorfont

} # Fim da função.

###############################
## Modo detalhado do pacote  ##
###############################
function verbose {

  if [ -n "$1" ]; then
     [ -e packagesmain -a -e packagescontrib -a -e packagesnonfree ] && \
     zcat /tmp/packages/packa* | sed -n "/Package: $1$/,/SHA256:/p"  || \
     echo $errorfont
  else
     echo $notargument
  fi

} # Fim da função.

#######################################
## Função pesquisa pacote específico ##
#######################################
function search {

  if [ -n "$1" ]; then
     
     if [ -e packagesmain -a -e packagescontrib -a -e packagesnonfree ]; then
        valor=$(zcat /tmp/packages/packa*)
        [ -n "$valor" ] && { grep '^Package:' | cut -d' ' -f2 |  grep "$1"; } <<< $valor
     else
       echo $errorfont
     fi
    
  else
    echo $notargument
  fi

} # Fim da função.

###############################
## Função para mostrar ajuda ##
###############################
function help {

cat << EOF
NOME
       proposedsch - lista pacotes do repositório debian proposed-updates.

SINOPSE
       proposedsc [opções]
       proposedsc [opções] [pacote...]
       proposedsc -v [pacote_nome...]
       proposedsc -s [pacote_nome...]

DESCRIÇÃO
       O script proposedsc é utilizado para pesquisar pacotes presentes no repositório proposed-updates, sem fazer qualquer alteração,
       no arquivo sources.list, ele baixa em /tmp/ uma fonte para pequisas de pacotes, no qual o script se baseia para pesquisar.
       O script tem o intuíto de facilitar quem precisa saber se há uma atualização de um software aguardando nesse repositório, faci-
       litando sua pesquisa e posterior instação, sem ter que mexer no arquivo sources.list.
       Esse script só lista pacotes das seções "main, contrib e nonfree" da arquitetura AMD64, outras arquiteturas não são suportadas.

OPÇÕES CURTAS/LONGAS
       -a     Mostra o nome de todos os pacotes presentes no repositório, formato longo "--all"

       -u     Realiza em /tmp/packages/ o downlaod de arquivos do repositório para pesquisa, formato longo "--update"

       -t     Mostra um valor do total de pacotes disponíveis para atualização, formato longo "--total"

       -h     Mostra opção ajuda, formato longo "--help"

       -s     Esse opção requer um argumento, com um nome de pacote, exemplo: proposedsch -s gimp, formato longo "--search"

       -v     Exibe informações detalhadas do pacote, essa opção requer argumento, exemplo: proposedsch -v gimp, formato longo "--verbose"
EOF

} # Fim da função.

######################
## Inicio do script ##
######################

case "$1" in

  -u|--update)  packages;;
  -a|--all)     all_packages;;
  -h|--help)    help;;
  -s|--search)  search "$2";;
  -v|--verbose) verbose "$2";;
  -t|--total)   valorpackage;;
   *) help
      exit 1

esac
