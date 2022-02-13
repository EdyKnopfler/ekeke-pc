## Streaming de vídeo

* [Vídeo do computador engasgando no YouTube](https://drive.google.com/file/d/13hOumPMO-s5PBKxSDxw2UgU5GHPnHk0g/view?usp=sharing)
* [Vídeo do computador reproduzindo o vídeo suavemente](https://drive.google.com/file/d/1754jjdy9fZNnqHfpviIcOxxF179Erfey/view?usp=sharing)

### Máquina de teste

Asus Eee PC 4g (modelo 701) [1]

* Celeron M ULV 900MHz
* memória RAM de fábrica 512 MB, aumentada para 1GB
* 4GB de armazenamento interno, algo como uma memória flash ou SSD primitivo
* SD card de 30GB
  * configurável na BIOS como armazenamento principal
  * onde foi instalado todo o software

### Software de sistema 

* S.O. Debian netinstall, firmware, nonfree 
  * usei o mais atual neste instante, o Debian 11 Bullseye
* Desktop LXDE
  * não escolhi pelo instalador
  * instalei o sistema básico sem software adicional
  * instalado LXDE mínimo pelo pacote `lxde-core`
  * softwares adicionais do LXDE pelos respectivos pacotes
    * `lxappearance`, `lxtask`
* Driver openchrome para adaptador de vídeo Intel GMA 900 [2]
  * produziu melhora visível; sempre verifique se está aproveitando o adaptador ao máximo
* NetworkManager e front-end `nm-tray`

### Software de aplicação

* Browser SeaMonkey
   * único que rodou vídeos do YouTube em experimentos anteriores, com máquinas antigas porém um pouco melhores
* Browser NetSurf
  * sugestão do Giuliano; browser sem suporte a JavaScript
  * opção para ler de forma limpa e leve as páginas carregadas de anúncios que sobrecarregam o computador
* Processador de textos AbiWord
* Planilha Gnumeric
* Editor de texto plano Mousepad
  * ajuda a editar scripts e arquivos de configuração
  * pode ser útil para o usuário final
* yt-dlp [3]
  * baixa vídeos do YouTube, obtém formatos disponíveis e link para streaming
  * fork do youtube-dl
  * atualização recente
* `mplayer`
  * player de vídeo em linha de comando
  * suporta streaming; usado em conjunto com o yt-dlp [4]
* `xclip`
  * interação com clipboard do sistema
  * comodidade para os scripts que fazem streaming ou download, bastando copiar o link
* `mpv`
  * frontend para o mplayer
  * interface amigável para reprodução de vídeos baixados

### Tunings

* cache_pressure [5][6]
  * default no Linux é 100
  * ajustado para 10 em máquinas muito antigas
* I/O scheduler [5][7]
  * não ajustado nesta máquina pois não possui disco rígido
  * usado BFQ em experimentos anteriores

### Contexto

Muito se fala em como o Linux pode dar um fôlego a computadores defasados, porém o conteúdo vai pouco além de listar distribuições consideradas leves. Isso, somado ao uso de browsers também considerados leves, pode ser suficiente em muitos casos. Por algum tempo testei várias delas em laptops bem antigos (cerca de 10 anos de idade) que estavam parados em casa. Tendo lido um post do Fabio Akita [5], resolvi testar os tunings do cache e do escalonador de E/S, conseguindo melhorar significativamente o desempenho. Nessas máquinas em específico, o SeaMonkey foi o único browser que conseguiu rodar vídeos do YouTube, então considerei que elas foram revividas com sucesso. Não ficaram "rápidas", porém estavam responsivas e usáveis. Foram doadas a duas mães com crianças em idade escolar.

No entanto, permaneceu a questão: como fazer um computador bem mais antigo dar conta de reproduzir vídeos em streaming, um uso tão trivial hoje em dia? É certo que o YouTube é muito antigo e na época não havia full HD, mas mesmo abrindo mão disso o desempenho do browser hoje ao reproduzir vídeo em streaming nelas é sofrível. De lá para cá o YouTube e o software mudou para se adaptar às tecnologias mais novas: multicore, full HD, conexões em fibra óptica... Se for possível fazer uma carroça consumir esse streaming, muita velharia parada pode ser reaproveitada ou doada.

Recentemente encontrei à venda no Marketplace do Facebook um pequeno laptop que havia sido cobaia de um experimento no canal Diolinux [8], em estado de novo. Imediatamente comprei e comecei a fazer experimentos, cujos resultados publico neste repositório do GitHub. Provavelmente ainda há mais melhorias que podem ser feitas. Instalei o S.O. básico de maneira semelhante aos primeiros com que experimentei e a primeira coisa foi conferir se o SeaMonkey rodava bem o YouTube: não roda, rapidamente o vídeo é ajustado para 144p e ainda ficava dando alguns lags. Procurei uma forma de realizar streaming por software alternativo.

A ideia é que o usuário possa simplesmente copiar o link e acionar os scripts por lançadores no desktop -- pensando em usuários sem intimidade com o terminal. Os scripts então usam os softwares `xclip` para ler o clipboard, `yt-dlp` para obter o link do stream (ou, alternativamente, baixar o vídeo) e o mplayer para execuá-lo. O desempenho foi satisfatório no laptop em qualidade 360p, o que já era antecipado e também não é grande problema pois a resolução da tela é apenas 800x480!


### Referências

* [1] https://icecat.biz/br/p/asus/eeepc4g-bk054/eee+pc-notebooks-eee+pc+4g-1621096.html
* [2] https://forums.linuxmint.com/viewtopic.php?t=345457
* [3] https://github.com/yt-dlp/yt-dlp/releases
* [4] https://www.youtube.com/watch?v=QCuq0_nY3Xk
* [5] https://www.akitaonrails.com/2017/01/17/optimizing-linux-for-slow-computers
* [6] https://www.linuxadictos.com/en/cache-pressure-optimizes-linux-performance.html
* [7] https://www.cloudbees.com/blog/linux-io-scheduler-tuning
* [8] https://www.youtube.com/watch?v=2Pms0HOFSng
