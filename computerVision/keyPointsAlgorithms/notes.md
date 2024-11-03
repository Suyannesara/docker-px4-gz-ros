
### Acerca dos keypoints
Pontos de interesse são pontos em uma imagem que são distintos e fáceis de reconhecer, e "corners" são um exemplo clássico desses pontos.
Pontos de interesse = são um tipo de feature. Keypoint = feature
Algoritmos detectores (detectors) -> usados para encontrar os pontos de interesse
Algoritmos descritores (descriptors) -> usados para descrever as features

Um ponto de interesse deve:
- Ser fácil de encontrar

- Fácil de computar

- E que esteja em um bom local na imagem para que seja bem computado o seu descritor

#### Filtro Gaussiano
Muitos métodos para detecćão dos pontos de interesse primeiro aplicam um FILTRO GAUSSIANO na imagem:
- A ideia de usar esse filtro é para reduzir os ruídos na imagem

- Isso porque, os operadores de gradiente aplicados depois, tendem a aumentar os ruídos na imagem

### Detectores e suas invariâncias
Cada detector localiza features com diferentes graus de invariância para atributos como rotação, escala, perspectiva, oclusão e iluminação.
Sendo que destes, um dos grandes desafios é a **mudanca de escala**, visto que quando a escala é alterada, os pontos de interesse detectados tendem a mudar drasticamnete.


#### Detectores de Corners (cantos)
É um ponto da imagem onde há uma variação acentuada de intensidade em várias direções (ou seja, a mudança de cor ou contraste é abrupta em pelo menos duas direções). Esses pontos geralmente aparecem onde duas bordas se encontram, como nas quinas de um objeto ou em uma interseção de linhas.

| **Critério**                      | **Detectores de Cantos**                               | **Detectores de Bordas**                                  | **Detectores de Blobs**                                   |
|-----------------------------------|--------------------------------------------------------|------------------------------------------------------------|-----------------------------------------------------------|
| **O que detectam**                | Pontos onde duas ou mais bordas se encontram (quinas)  | Áreas de transição de intensidade entre regiões diferentes (contornos) | Regiões homogêneas que se destacam do fundo                |
| **Aplicações Principais**         | Rastreamento de características únicas (ex: quinas de objetos) | Delimitação de formas e contornos (ex: bordas de objetos)   | Detecção de áreas amplas ou salientes (ex: objetos circulares ou manchas) |
| **Benefícios**                    | - **Moravec**: Simples, rápido<br> - **Harris-Stephens**: Invariante a rotação e escala, robusto a ruído<br> - **Shi-Tomasi**: Alta precisão<br> - **FAST/Faster**: Muito rápido, ideal para tempo real<br> - **AGAST**: Melhor desempenho em diferentes condições | - **LoG**: Bom para bordas em várias escalas<br> - **DoG**: Usado em SIFT, detecta mudanças de intensidade<br> - **SUSAN**: Simples, rápido, tolerante a ruído | - **Hessian Matrix/Laplace**: Bom para detectar blobs em várias escalas<br> - **DoG**: Bom para detectar blobs em diferentes resoluções<br> - **Salient Regions**: Detecta regiões proeminentes e relevantes |
| **Malefícios**                    | - **Moravec**: Sensível a ruído<br> - **Harris-Stephens**: Pode falhar em texturas homogêneas<br> - **Shi-Tomasi**: Sensível a ruído e iluminação<br> - **FAST/Faster**: Sensível a rotações e escala<br> - **AGAST**: Menos robusto que Harris em texturas homogêneas | - **LoG**: Alta demanda computacional, sensível a ruídos<br> - **DoG**: Sensível a ruído, falha em áreas homogêneas<br> - **SUSAN**: Desempenho inferior em texturas complexas | - **Hessian**: Alta complexidade computacional<br> - **DoG**: Custo computacional elevado<br> - **Salient Regions**: Alta complexidade de cálculo, falha em ambientes com baixo contraste |
| **Invariância**                   | Invariantes a rotação (dependendo do detector), alguns invariante a escala | Não invariantes a escala e rotação (por padrão)             | Invariantes a escala, mas sensíveis a iluminação           |
| **Cenários Ideais**               | Detecção de quinas ou pontos de interesse em imagens fixas e vídeos | Detecção de bordas para delimitar objetos e seus contornos | Identificação de regiões homogêneas e proeminentes         |
| **Custo Computacional**           | Moderado a alto (dependendo do detector)               | Moderado (LoG e DoG mais custosos)                         | Alto (Hessian e Salient Regions com alta complexidade)     |

**Resumo:**
- **Detectores de Cantos**: São usados para rastreamento e detecção de quinas, com algoritmos rápidos como **FAST** e mais robustos como **Harris-Stephens**.
- **Detectores de Bordas**: Ideais para segmentação e contorno de objetos, com detectores como **LoG** e **DoG** lidando bem com mudanças de intensidade.
- **Detectores de Blobs**: Encontram regiões salientes e homogêneas, com métodos como **Hessian-Laplace** sendo robustos a variações de escala, mas exigindo maior poder de processamento.

### Descritores

| **Critério**                      | **Descritores Binários**                                     | **Descritores de Gradientes**                                |
|-----------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| **Situações de Uso**              | Matching de keypoints em imagens estáticas e vídeos, detecção em tempo real | Detecção e matching de pontos em imagens complexas, reconhecimento de objetos e detecção de pedestres |
| **Benefícios**                    | - **BRIEF**: Rápido, eficiente, baixa demanda de memória.  <br>- **ORB**: Invariante a rotação e escala, combina FAST com BRIEF, rápido e eficiente. <br>- **BRISK**: Invariante a rotação e escala, bom para matching robusto e rápida execução. <br>- **FREAK**: Rápido e eficiente, baseado em características biológicas como visão humana. | - **SIFT**: Invariante a rotação, escala e iluminação, alta precisão, robusto para diferentes cenários. <br>- **SURF**: Invariante a rotação e escala, mais rápido que SIFT, robusto a ruídos. <br>- **HOG**: Bom para detectar formas e bordas, invariante a pequenas variações de pose. <br>- **Daisy**: Bom para capturar padrões locais, invariante a rotação, boa precisão em matching de imagens. <br>- **O-Daisy**: Mais robusto a rotações e mudanças de perspectiva que Daisy. |
| **Malefícios**                    | - **BRIEF**: Não invariante a rotação ou escala, sensível a mudanças de iluminação. <br>- **ORB**: Menos preciso que SIFT/SURF em ambientes complexos. <br>- **BRISK**: Não tão robusto quanto SIFT ou SURF para detecção em cenários mais complexos. <br>- **FREAK**: Não invariante a escala, pode ser menos preciso que SURF em cenários complexos. | - **SIFT**: Custo computacional elevado, patenteado (restrições de uso comercial). <br>- **SURF**: Também patenteado, menos preciso que SIFT para pequenos detalhes. <br>- **HOG**: Não invariante a escala e rotação, menos eficiente em cenários com iluminação variável. <br>- **Daisy**: Menos robusto a variações de iluminação e escala, mais lento que HOG em algumas aplicações. <br>- **O-Daisy**: Demanda computacional maior, ainda sensível a variações de iluminação. |

Esses descritores são usados para identificar e representar keypoints em imagens, especialmente em tarefas como correspondência de pontos de interesse e detecção de objetos em visão computacional.


### Detectores - Detalhado

| **Detector**                     | **Situações de Uso**                                      | **Benefícios**                                                                                 | **Malefícios**                                                                                       | **Classe**                   |
|-----------------------------------|-----------------------------------------------------------|------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|------------------------------|
| **Moravec Corner Detector**       | Detectar cantos em imagens estáticas                      | Simplicidade, rápido de calcular                                                                 | Sensível a ruído, não invariante a rotações                                                            | Detector de Cantos            |
| **Laplacian & Laplacian of Gaussian (LoG)** | Detecção de bordas e blobs em diferentes escalas           | Bom para detectar bordas em várias escalas, invariante a escala                                     | Demanda computacional alta, sensível ao ruído                                                          | Detector de Bordas            |
| **Harris-Stephens**               | Detecção de cantos em imagens estáticas                   | Invariante a rotações e escala, robusto a ruído                                                  | Pode falhar ao detectar cantos em texturas homogêneas                                                   | Detector de Cantos            |
| **Shi-Tomasi**                    | Rastreamento de cantos em vídeos                          | Melhor precisão na detecção de cantos, usado em algoritmos como KLT                               | Mais sensível a ruídos e iluminação do que Harris                                                      | Detector de Cantos            |
| **Hessian Matrix Detector**       | Análise de curvatura e bordas em imagens                  | Bom para detecção de blobs em várias escalas, estável para bordas                                  | Alta complexidade computacional                                                                        | Detector de Blobs             |
| **Hessian-Laplace**               | Detecção de pontos de interesse em várias escalas         | Invariante a escala, eficiente em imagens com diferentes resoluções                               | Custo computacional elevado, sensível a ruídos                                                         | Detector de Blobs             |
| **Difference of Gaussians (DoG)** | Detecção de bordas e blobs em diferentes escalas           | Usado em algoritmos como SIFT, bom para detectar mudanças de intensidade                          | Pode não detectar cantos em imagens homogêneas, sensível a ruído                                        | Detector de Bordas e Blobs    |
| **Salient Regions**               | Detecção de regiões proeminentes em uma imagem            | Detecta áreas visualmente relevantes, robusto para mudanças de iluminação e escala                | Alta complexidade de cálculo, pode falhar em ambientes com baixo contraste                             | Detector de Regiões Salientes |
| **SUSAN**                         | Detectar bordas e cantos em imagens                       | Simples e rápido, tolerante a ruído                                                               | Desempenho inferior em imagens com texturas complexas                                                  | Detector de Cantos e Bordas   |
| **Trajkovic and Hedly**           | Detecção de cantos em imagens                             | Detecta cantos de forma eficiente em imagens de baixo ruído                                       | Pode não funcionar bem em imagens ruidosas, menos preciso que Harris                                    | Detector de Cantos            |
| **FAST**                          | Detecção rápida de cantos em vídeos                       | Muito rápido, ideal para processamento em tempo real                                             | Não invariante a rotações ou escala, sensível a ruído                                                  | Detector de Cantos            |
| **Faster**                        | Versão otimizada do FAST para vídeos em tempo real        | Ainda mais rápido que o FAST, melhor eficiência para tracking em tempo real                       | Mesmo problema de sensibilidade a rotações e escala                                                    | Detector de Cantos            |
| **AGAST**                         | Extensão do FAST para melhorar detecção em diferentes condições | Melhor desempenho em diferentes condições de iluminação e ruído                                    | Ainda pode ser sensível a rotações, não tão robusto quanto Harris em texturas homogêneas                | Detector de Cantos            |

Essa tabela pode ajudar a entender melhor os métodos de detecção de pontos de interesse, suas aplicações específicas e como eles podem ser usados dependendo da necessidade e do contexto.


### Descritores - Detalhado
| **Descritor**                    | **Situações de Uso**                                         | **Benefícios**                                                                                | **Malefícios**                                                                                   | **Classe**                |
|-----------------------------------|--------------------------------------------------------------|-----------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|---------------------------|
| **BRIEF**                         | Matching de keypoints para imagens estáticas e vídeos        | Rápido, eficiente em ambientes de tempo real, baixa demanda de memória                         | Não invariante a rotação ou escala, sensível a mudanças de iluminação                             | Descritor Binário          |
| **ORB**                           | Detecção e descrição de keypoints em tempo real              | Invariante a rotação e escala, combina FAST com BRIEF, rápido e eficiente                      | Menos preciso que SIFT/SURF em ambientes complexos                                                 | Detector e Descritor Binário |
| **BRISK**                         | Rastreamento e matching em vídeos                            | Invariante a rotação e escala, bom para matching robusto e rápida execução                     | Não tão robusto quanto SIFT ou SURF para detecção em cenários mais complexos                      | Detector e Descritor Binário |
| **FREAK**                         | Aplicações de reconhecimento facial e de objetos             | Rápido e eficiente, baseado em características biológicas como visão humana                    | Não invariante a escala, pode ser menos preciso que SURF em cenários complexos                    | Descritor Binário          |
| **SIFT**                          | Detecção e matching de pontos em imagens complexas           | Invariante a rotação, escala e iluminação, alta precisão, robusto para diferentes cenários      | Custo computacional elevado, patenteado (restrições de uso comercial)                              | Detector e Descritor       |
| **SURF**                          | Rastreamento e matching em imagens e vídeos                  | Invariante a rotação e escala, mais rápido que SIFT, robusto a ruídos                          | Também patenteado, menos preciso que SIFT para pequenos detalhes                                  | Detector e Descritor       |
| **Histogram of Gradients (HOG)**  | Detecção de objetos, especialmente pedestres                 | Bom para detectar formas e bordas, invariante a pequenas variações de pose                     | Não invariante a escala e rotação, menos eficiente em cenários com iluminação variável             | Descritor de Gradientes    |
| **Daisy**                         | Reconhecimento de objetos e recuperação de imagens           | Bom para capturar padrões locais, invariante a rotação, boa precisão em matching de imagens     | Menos robusto a variações de iluminação e escala, mais lento que HOG em algumas aplicações         | Descritor de Gradientes    |
| **O-Daisy**                       | Versão orientada do Daisy para maior robustez                | Mais robusto a rotações e mudanças de perspectiva que Daisy                                    | Demanda computacional maior, ainda sensível a variações de iluminação                              | Descritor de Gradientes    |

**Resumo:**
- **Descritores Binários** como **BRIEF**, **ORB**, **BRISK** e **FREAK** são rápidos e eficientes, sendo usados em aplicações de tempo real, mas podem ser sensíveis a rotação e escala.
- **Descritores Clássicos** como **SIFT** e **SURF** são mais precisos e robustos, porém têm maior custo computacional e podem ter restrições de uso.
- **Descritores de Gradientes** como **HOG** e **Daisy** capturam informações estruturais, sendo utilizados para reconhecimento de formas e objetos, mas são menos robustos a variações de iluminação e escala.


### Outras infos
VIZINHOS DE PIXELS EM IMAGENS:
https://youtu.be/AjFURMXJTbw
https://www.youtube.com/watch?v=u5XB36Qfpjg

DETECACAO DE EDGES(ARESTAS) USANDO LAPLACIAN
O que é interessante acerca da segunda derivada, é que nas arestas do gráfico voce sempre vai encontrar valores de 0, e BEM proximos de zero.
O que nos leva a deduzir que sempre que usamos esse metodo da segunda derivada encontraremos arestas por meio da identificacao de valores 0 extremos. Aonde tiver 0 é um edge. Edges of zero-crossings.
- Laplaciano não fornece a direcão dos edges encontrados

RUÍDOS EM ARESTAS
- Precisamos suprimir os ruidos antes de aplicar o laplaciano
- Gaussiano é bem usado para isso

OPERADOR GRADIENT VS LAPLACIANO
file:///home/suyanne/Pictures/Screenshot_20240923_193433.png
