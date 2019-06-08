# Script proposedsch

## Descrição

O script proposedsc é utilizado para pesquisar pacotes presentes no repositório proposed-updates, sem fazer qualquer alteração,
no arquivo sources.list, ele baixa em /tmp/ uma fonte para pequisas de pacotes, no qual o script se baseia para pesquisar.
O script tem o intuíto de facilitar quem precisa saber se há uma atualização de um software aguardando nesse repositório, faci-
litando sua pesquisa e posterior instação, sem ter que mexer no arquivo sources.list.
Esse script só lista pacotes das seções "main, contrib e nonfree" da arquitetura AMD64, outras arquiteturas não são suportadas.

### instalação

``` 
su -

git clone https://github.com/Ferlinuxdebian/proposedsch.git

cd proposedsch/

chmod +x proposedsch.sh; cp proposedsch.sh /usr/local/bin/proposedsch
``` 

### Uso

```
OPÇÕES CURTAS/LONGAS

-a  Mostra o nome de todos os pacotes presentes no repositório, formato longo "--all"

-u  Realiza em /tmp/packages/ o downlaod de arquivos do repositório para pesquisa, formato longo "--update"

-t  Mostra um valor do total de pacotes disponíveis para atualização, formato longo "--total"

-h  Mostra opção ajuda, formato longo "--help"

-s  Esse opção requer um argumento, com um nome de pacote, exemplo: proposedsch -s gimp, formato longo "--search"

-v  Exibe informações detalhadas do pacote, essa opção requer argumento, exemplo: proposedsch -v gimp, formato longo "--verbose"
```

