## Streaming de vídeo em laptop muito antigo

* [Vídeo do computador engasgando no YouTube](https://drive.google.com/file/d/13hOumPMO-s5PBKxSDxw2UgU5GHPnHk0g/view?usp=sharing)
* [Vídeo do computador reproduzindo o vídeo suavemente](https://drive.google.com/file/d/1754jjdy9fZNnqHfpviIcOxxF179Erfey/view?usp=sharing)

### Máquina de teste

[Asus Eee PC 4g (modelo 701)](https://icecat.biz/br/p/asus/eeepc4g-bk054/eee+pc-notebooks-eee+pc+4g-1621096.html)

* Celeron M ULV 900MHz
  * roda por default a _"incríveis" 630MHz_, ativando o módulo `p4-clockmod` do kernel na utilização a potência total é utilizada
* memória RAM de fábrica 512 MB, aumentada para 1GB
* 4GB de armazenamento interno, algo como uma memória flash ou SSD primitivo
  * inicialmente o sistema foi instalado em um SDCard
  * posteriormente tentou-se enxugar a instalação para caber no armazenamento principal, tendo sobrado aproximadamente 500MB
* interface wireless USB alternativa ~1Gbit/s
  * onboard é somente 100Mbit/s

### Software de sistema 

**Obs. 1:** uma distro semelhante já configurada de forma próxima ao descrito e que deu bons resultados é a [Loc-OS](https://loc-os.sourceforge.io/)

**Obs. 2:** outra distro semelhante que também rodou bem na máquina foi a  [Raspberry Pi Desktop](https://www.raspberrypi.com/software/raspberry-pi-desktop/)

* S.O. Debian netinstall, firmware, nonfree 
  * usei o mais atual neste instante, o Debian 11 Bullseye
  * feito downgrade de Kernel para o 4.9 ativando temporariamente os repositórios do Debian 10 Buster
  * [kernel compilado](https://github.com/EdyKnopfler/compilando-kernel) diretamente para o processador da máquina, com corte de inúmeros módulos não usados
* Desktop LXDE
  * não escolhi pelo instalador
  * instalei o sistema básico sem software adicional
  * instalado LXDE mínimo pelo pacote `lxde-core`
  * softwares adicionais do LXDE pelos respectivos pacotes
    * `lxappearance`, `lxtask`
* NetworkManager e front-end `nm-tray`
  * substituições possíveis: `connman` e `connman-gtk`
* Utilitários do antiX como o [advert blocker](https://github.com/antiX-Linux/advert-block-antix) tornam a navegação muito mais fluida
  * o excesso de anúncios realmente compromete a navegação nessas máquinas!
* [Trocado `systemd` pelo `sysvinit`](https://wiki.debian.org/Init)

### Software de aplicação

* Browser [SeaMonkey 2.53.9](http://ftp.mozilla.org/pub/mozilla.org/seamonkey/releases/)
   * Foi o que rodou vídeos do YouTube em experimentos anteriores, com máquinas antigas porém um pouco melhores
   * Favoritadas páginas móveis do YouTube (por onde o usuário pode copiar os links para acionar os scripts) e Facebook, por serem mais leves
* LibreOffice
   * testado contra AbiWord e Gnumeric; neste caso específico o LO funcionou melhor porém em outros foi diferente
* Editor de texto plano Mousepad
  * ajuda a editar scripts e arquivos de configuração
  * pode ser útil para o usuário final
* [yt-dlp](https://github.com/yt-dlp/yt-dlp/releases)
  * baixa vídeos do YouTube, obtém formatos disponíveis e link para streaming
  * fork do youtube-dl
  * atualização recente
* `xclip`
  * interação com clipboard do sistema
  * comodidade para os scripts que fazem streaming ou download, bastando copiar o link
* VLC
  * player que apresentou o melhor desempenho ao ser chamado pelo script para "streamar" o vídeo

### [Tunings](https://www.akitaonrails.com/2017/01/17/optimizing-linux-for-slow-computers)

* [swappiness](https://www.google.com/search?client=firefox-b-d&q=swappiness)
  * ajustado para 1 (casos extremos) em máquinas muito antigas
* [cache_pressure](https://www.linuxadictos.com/en/cache-pressure-optimizes-linux-performance.html)
  * default no Linux é 100
  * ajustado para 50 em máquinas muito antigas, com pouca memória
  * pode ser útil após um upgrade na RAM, para acelerar um pouco o acesso aos arquivos
* [I/O scheduler](https://www.cloudbees.com/blog/linux-io-scheduler-tuning)
  * usado BFQ em máquinas muito antigas

### Contexto

Muito se fala em como o Linux pode dar um fôlego a computadores defasados, porém o conteúdo vai pouco além de listar distribuições consideradas leves. Isso, somado ao uso de browsers também considerados leves, pode ser suficiente em muitos casos. Por algum tempo testei várias delas em laptops bem antigos (cerca de 10 anos de idade) que estavam parados em casa. Tendo lido um [post do Fabio Akita](https://www.akitaonrails.com/2017/01/17/optimizing-linux-for-slow-computers), resolvi testar os tunings do cache e do escalonador de E/S, conseguindo melhorar significativamente o desempenho. Nessas máquinas em específico, o SeaMonkey foi o único browser que conseguiu rodar vídeos do YouTube, então considerei que elas foram revividas com sucesso. Não ficaram "rápidas", porém estavam responsivas e usáveis. Foram doadas a duas mães com crianças em idade escolar.

No entanto, permaneceu a questão: como fazer um computador bem mais antigo dar conta de reproduzir vídeos em streaming, um uso tão trivial hoje em dia? É certo que o YouTube é muito antigo e na época não havia full HD, mas mesmo abrindo mão disso o desempenho do browser hoje ao reproduzir vídeo em streaming nelas é sofrível. De lá para cá o YouTube e o software mudou para se adaptar às tecnologias mais novas: multicore, full HD, conexões em fibra óptica... Se for possível fazer uma carroça consumir esse streaming, muita velharia parada pode ser reaproveitada ou doada.

Recentemente encontrei à venda no Marketplace do Facebook um pequeno laptop que havia sido cobaia de um [experimento no canal Diolinux](https://www.youtube.com/watch?v=2Pms0HOFSng), em estado de novo. Imediatamente comprei e comecei a fazer experimentos, cujos resultados publico neste repositório do GitHub. Provavelmente ainda há mais melhorias que podem ser feitas. Instalei o S.O. básico de maneira semelhante aos primeiros com que experimentei e a primeira coisa foi conferir se o SeaMonkey rodava bem o YouTube: não roda, rapidamente o vídeo é ajustado para 144p, fica dando muitos lags e a máquina perde completamente a responsividade. Procurei uma forma de realizar streaming por software alternativo.

A ideia é que o usuário possa simplesmente copiar o link e acionar os scripts por lançadores no desktop -- pensando em usuários sem intimidade com o terminal. Os scripts então usam os softwares `xclip` para ler o clipboard, `yt-dlp` para obter o link do stream (ou, alternativamente, baixar o vídeo) e o mplayer para executá-lo. O desempenho foi satisfatório no laptop em qualidade 360p, o que já era antecipado e também não é grande problema pois a resolução da tela é apenas 800x480!
