#Teoria de Grafos com aplicação no R - Workshop Escola Livre de IA

library(igraph)

#Grafos via Data frame
nos=c("A","B","C","D","E","F")
ligacoes=data.frame(origem=c(rep("A",2),
                             rep("B",2),"C","D","E","F"),
                    destino=c("B","D","C","E","D","E","F","B"))

#Criando o grafo a partir de um Data.frame
grafo1 = graph_from_data_frame(d=ligacoes, 
                               vertices=nos, 
                               directed=F) 
grafo1

#Plotando o grafo
plot(grafo1, vertex.label=no,
             vertex.size=20,
             edge.width=5, 
             layout=layout_as_star(grafo1),
             main="Grafo 1")

#Extraindo a matriz de adjacências
matriz <- get.adjacency(grafo1)

#Grafos via Matriz de adjacência

#Criando o vetor com as relações das arestas e vértices
vetor=c(0,1,rep(0,4),
        1,0,1,0,1,0,
        0,1,rep(0,3),1,
        rep(0,6),
        0,1,rep(0,3),1,
        0,0,1,0,1,1)

#Segunda alternativa
arestas_a = c(0,1,0,0,0,0)
arestas_b = c(1,0,1,0,1,0)
arestas_c = c(0,1,0,0,0,1)
arestas_d = c(0,0,0,0,0,0)
arestas_e = c(0,0,1,0,1,1)
arestas_f = c(0,0,1,0,1,1) 

vetor=c(arestas_a,arestas_b,arestas_c,
        arestas_d,arestas_e,arestas_f)

#Criando a matriz de adjacências
matriz_adja=matrix(vetor, 
                   nrow=6, ncol=6,byrow=TRUE)

rownames(matriz_adja)=c("A","B","C","D","E","F")
colnames(matriz_adja)=c("A","B","C","D","E","F")

grafo2=graph_from_adjacency_matrix(matriz_adja, mode="undirected")

plot(grafo2,vertex.size=50)

library(rgl)

#2d interativo
tkplot(grafo1)
#3d
rglplot(grafo1,
        vertex.label=unique(ligacoes$origem),
        vertex.size=5, 
        layout=layout_in_circle(grafo1))

#Grafos com visNetwork
install.packages("visNetwork")
library(visNetwork)

nos <- data.frame(id = 1:6, label = c("A","B","C","D","E","F"),
                    color = c("#38B0DE","#EEAEEE","#66FF66","#66FF66","#EEAEEE","#38B0DE"),
                    shape = c("square","diamond","triangle","square","diamond","triangle"))
ligacoes <- data.frame(from = c(1,2,2,3,6,4), to = c(2,3,5,6,6,0))
vis1=visNetwork(nos, ligacoes)
vis1
                                                                                           
#layouts distintos

#script da KATETO para multiplos layouts

#Pegar os layouts da função
layouts <- grep("^layout_", ls("package:igraph"), value=TRUE)[-1]
# Remove layouts that do not apply to our graph.
layouts <- layouts[!grepl("bipartite|merge|norm|sugiyama|tree", layouts)]

par(mfrow=c(3,3), mar=c(1,1,1,1))
for (layout in layouts) {
  print(layout)
  l <- do.call(layout, list(grafo1))
  plot(grafo1, layout=l, main=layout) }

#Com as função V() relação dos vértices/nós 
V(grafo1) 

#Número de vértices/nós
gorder(grafo1)

#Com as função E() e das arestas.
E(grafo1)       

#Número de arestas
gsize(grafo1)

#Graus dos vértices/nós
grau=degree(grafo1)

#Ordenar os graus
graus_ord=sort(grau, decreasing = F)

#Visualizando no gráfico de barras
barplot(graus_ord, col="tomato", main="Grau dos vértices")

#Exercício

#Cálculo do número de arestas de um grafo k15 (completo)
m=factorial(15)/(factorial(15-2)*factorial(2))
m
m=15*14/2

#Estatísticas descritivas
summary(grau)

#Boxplot
boxplot(grau)

#Distribuição de frequências acumuladas
grau.dist <- degree_distribution(grafo1, cumulative=T, mode="all")
plot( x=0:max(degree(grafo1)), y=1-grau.dist, pch=19, cex=1.2, col="orange", 
      xlab="Graus", ylab="Frequência acumulada")

#cliques(grafo1)
a=max_cliques(grafo1)

#Cliques
par(mfrow=c(3,2))
for (i in 1:length(a)){
  print(plot(induced.subgraph(grafo1,vids=a[[i]])))
}

#Para determinar o tamanho (quantidade de vértices) do maior clique em um grafo pode-se utilizar a função clique.number(). 
clique.number(grafo1)

#criando grafos aleatoriamente

#com graus fixos
library(igraph)
degs <- c(2,2,2,2,3,3,2,2)
g1 <- degree.sequence.game(degs, method="vl")
plot(g1, vertex.label=NA)

#com vértices e arestas fixas
nv=7
ne=5
g3=erdos.renyi.game(nv, ne, type="gnm")
plot(g3, vertex.label=NA)

#Verificando se dois grafos são isomorfos
graph.isomorphic(grafo1,grafo2)

#Métricas em Redes Complexas

#Closeness - Proximidade - O quão próximo cada vértice está dos demais
closeness(grafo1)

#Betweenness – Intermediação - (Vértice): 
#quantifica o número de vezes que um VÉRTICE age como
#ponte ao longo do caminho mais curto entre dois outros vértices.
betweenness(grafo1)

#Para chegar na medida

#1. Para cada par de vértices calcular os caminhos mais curtos entre eles.
#2. Para cada par de vértices determinar a fração de caminhos mais curtos que passam
#através do vértice em questão.
#3. Somar esta fração de todos os pares de vértices.

#Betweenness – Intermediação - (Aresta): 
#quantifica o número de vezes que uma Aresta age como
#ponte ao longo do caminho mais curto entre dois outros vértices.
edge_betweenness(grafo1)


#Modularidade
#Uma característica importante das redes e que é usada com frequência na detecção de comunidades é expressa pelo conceito de modularidade. 

#A modularidade é uma estatística que varia de -1/2 a 1, 
#sendo que quanto mais próxima de 1 mais agrupados estarão os vértices.

#algoritmo edge-betweenness implementado pela função cluster_edge_betweeness()
cm = cluster_edge_betweenness(grafo1)
modularity(cm)

#Foram identificados 2 subgrafos, sendo que no grupo 1 foram classificados 3 vertices e no grupo 2, 3 também,
subgrafos = membership(cm)
sizes(cm)

#Quem são os subgrafos
cm

#Plotando os subgrafos
plot(cm, grafo1, vertex.size=6)

#Clusters hierárquicos
hc = fastgreedy.community(grafo1)
#Foram identificados 2 Clusters, sendo que no grupo 1 foram classificados 3 vertices e no grupo 2, 3 também,
subgrafos2 = membership(hc)
sizes(hc)
#Quem são os clusters
hc

#Plotando os Clusters
plot(hc, grafo1)

#Plotando o dendograma
library(ape)
dendPlot(hc, mode="phylo")


#kateto

setwd("C:\\Users\\teste\\Desktop\\Workshops\\Workshop Grafos - Escola Livre de IA")


##Exemplo bônus
nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

#Vendo os dados
head(nodes)
#dados das relações
head(links)
#Criando o grafo
net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 
net

plot(net)
net <- simplify(net, remove.multiple = F, remove.loops = T) 
plot(net)

#---
#intergraph

#Verificando a classe
class(net)
library(intergraph)
library(network)
library(GGally)
#Transformando em um objeto 
#Converter classes  asNetwork e asIgraph
net2=asNetwork(net)

#Verificando a classe
class(net2)

#Criando uma variável indicadora para a audiência
net2 %v% "indicadora_audiencia" = ifelse(nodes$audience.size>=30, ">=30", "<30")

#Colocando cor na rede, utilizando a indicadora de audiência
ggnet2(net2, color = "indicadora_audiencia")

#Padronizando as cores conforme desejarmos
net2 %v% "color" = ifelse(net2 %v% "indicadora_audiencia" == ">=30", "steelblue", "tomato")

#Exibindo as redes com as novas cores
ggnet2(net2, color = "color")

#Exibindo as redes com novas paletas de cores
ggnet2(net2, color = "indicadora_audiencia", palette = "YlGnBu")

#Mostrando Todas as paletas do pacote RColorBrewer
RColorBrewer::display.brewer.all()
#App com cores para esoclha
#https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3

#Evidenciar diferenças de tamanho
ggnet2(net2, size = "indicadora_audiencia", size.palette = c(">=30" = 10, "<30" = 1))

#Evidenciar diferenças de tamanho dos graus
ggnet2(net2, size = "degree")

#Evidenciar diferenças de tamanho dos graus e tamanho
ggnet2(net2, color=degree(asIgraph(net2)),palette="YlGnBu")

#Evidenciar classes de graus
ggnet2(net2, size = "degree", size.cut = 5,color="#1b9e77")

#Modificar a legenda 
ggnet2(net2, alpha = "indicadora_audiencia", alpha.legend = "Indicadora audiência")

#Juntando dois filtros (grau e audiencia)
ggnet2(net2, size = "degree", size.cut = 5,color="#1b9e77",alpha = "indicadora_audiencia")

#Modificando labels e cores e tamanho da legenda
ggnet2(net2, color = "indicadora_audiencia")+ 
  scale_color_brewer("", palette = "Spectral",
                     labels = c(">=30" = "Alta", "<30" = "Baixa"),
                     guide = guide_legend(override.aes = list(size = 7)))

#Modificando temas e posição da legenda e tamanho
ggnet2(net2, color = "indicadora_audiencia", legend.size = 12, legend.position = "bottom") +
  theme(panel.background = element_rect(color = "blue"))+
  scale_color_brewer("", palette = "Spectral")

#Outra paleta
ggnet2(net2, color = "indicadora_audiencia", legend.size = 12, legend.position = "bottom") +
  theme(panel.background = element_rect(color = "blue"))+
  scale_color_brewer("", palette = "YlGnBu")

#Colocando label
ggnet2(net2, color = "indicadora_audiencia", size = 12, label = TRUE, label.size = 5)+
  scale_color_brewer("", palette = "Spectral")

#Outro background
ggnet2(net2, color = "grey15", size = 12, label = TRUE, label.color = "green") +
  theme(panel.background = element_rect(fill = "grey15"))

#Tipos de forma
ggnet2(net2, color = "indicadora_audiencia", shape = 18)

#Tipos por indicadora
ggnet2(net2, color = "indicadora_audiencia", shape = "indicadora_audiencia")

#------------
#ggnet
#plotly

library(ggnetwork)
library(ITNr)
library(plotly)

n<-ggnetwork(net2)

ggplotly(
  ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
    geom_edges(color = "grey50") +
    geom_nodes(aes(color = as.factor(indicadora_audiencia),size=audience.size)) +
    guides(color=FALSE,size=FALSE)+ 
    theme_blank()
)


vs <- V(net) #lista de nós
es <- as.data.frame(get.edgelist(net)) #lista de vértices
node.data<-get.data.frame(net,what="vertices") # dataframe de nós

Nv <- length(vs) #número de nós
Ne <- length(es[1]$V1) #número de vértices

L <- layout.fruchterman.reingold(net)
Xn <- L[,1]
Yn <- L[,2]

network <- plot_ly(x = ~Xn, y = ~Yn, #coordenada dos nós
                   mode = "markers", 
                   text = vs$media, 
                   hoverinfo = "text",
                   color =as.factor(node.data$media) )

network

#Outro exemplo
net3 <- graph_from_data_frame(d=links, vertices=nodes, directed=F) 
net3

net3 <- simplify(net3, remove.multiple = T, remove.loops = T) 
plot(net3)

#Encontrando comunidades (otimizando as modularidades)
clp3 <- cluster_optimal(net3)
class(clp3)

plot(clp3, net3,vertex.label=nodes$media)

#Clusters hierárquicos
hc3 = fastgreedy.community(net3)
#Foram identificados 2 Clusters, sendo que no grupo 1 foram classificados 3 vertices e no grupo 2, 3 também,
subgrafos3 = membership(hc3)
sizes(hc3)
#Quem são os clusters
hc3

#Plotando os Clusters
plot(hc3, net3,vertex.label=nodes$media)

#Plotando o dendograma
dendPlot(hc3, mode="phylo")

#2d interativo
tkplot(net3)

#Exemplo Statistical Analysis of Network Data with R  
#Simulação de Monte carlo

nv <- vcount(net3)
ne <- ecount(net3)
degs <- degree(net3)
ntrials <- 1000

num.comm.rg <- numeric(ntrials)
for(i in (1:ntrials)){
  g.rg <- erdos.renyi.game(nv, ne, type="gnm")
  c.rg <- fastgreedy.community(g.rg)
  num.comm.rg[i] <- length(c.rg)
}

num.comm.grg <- numeric(ntrials)
for(i in (1:ntrials)){
  g.grg <- degree.sequence.game(degs, method="vl")
  c.grg <- fastgreedy.community(g.grg)
  num.comm.grg[i] <- length(c.grg)
}

rslts <- c(num.comm.rg,num.comm.grg)
indx <- c(rep(0, ntrials), rep(1, ntrials))
counts <- table(indx, rslts)/ntrials
barplot(counts, beside=TRUE, col=c("blue", "red"),
        xlab="Number of Communities",
        ylab="Relative Frequency",
        legend=c("Fixed Size", "Fixed Degree Sequence"))


#----------
library("animation") 

l <- layout_with_lgl(net)

saveGIF( {  col <- rep("grey40", vcount(net))
plot(net, vertex.color=col, layout=l)

step.1 <- V(net)[media=="Wall Street Journal"]
col[step.1] <- "#ff5100"
plot(net, vertex.color=col, layout=l)

step.2 <- unlist(neighborhood(net, 1, step.1, mode="out"))
col[setdiff(step.2, step.1)] <- "#ff9d00"
plot(net, vertex.color=col, layout=l) 

step.3 <- unlist(neighborhood(net, 2, step.1, mode="out"))
col[setdiff(step.3, step.2)] <- "#FFDD1F"
plot(net, vertex.color=col, layout=l)  },
interval = .8, movie.name="network_animation.gif" )

library("ndtv")
data(short.stergm.sim)

View(as.data.frame(short.stergm.sim))
render.d3movie(short.stergm.sim,displaylabels=TRUE) 

#https://kateto.net/network-visualization


#----

#Bônus: Grafos ouvintes Workshop UFV

library(readxl)

dados_ouvintes_grafo=read_excel("ouvintes_ufv.xlsx", 
                                sheet = 1)
names(dados_ouvintes_grafo)=c("data","nome","cluster","cluster_nome")

#library(stringr)
#for (i in 1:dim(dados_ouvintes_grafo)[1]){
#  separar[i]=str_split_fixed(dados_ouvintes_grafo$cluster,fixed('|'),2)[i]
#  dados_ouvintes_grafo$cluster2[i]=as.numeric(separar[i])
#}

link_teste=table(dados_ouvintes_grafo$cluster_nome,dados_ouvintes_grafo$nome)

net_teste <- graph_from_incidence_matrix(link_teste)
plot(net_teste)

library(png)
img.1 <- readPNG("./images/IA.png")
img.2 <- readPNG("./images/user.png")

V(net_teste)$raster <- list(img.1, img.2)[V(net_teste)$type+1]

plot(net_teste, vertex.shape="raster", vertex.label=NA,
     vertex.size=15, vertex.size2=20, edge.width=4)

img.3 <- readPNG("./images/IA.png")
rasterImage(img.3,  xleft=-2.0, xright=-1, ybottom=-1.1, ytop=0.1)

#links de referência para estudo
#https://kateto.net/network-visualization
#https://briatte.github.io/ggnet/
#https://matthewsmith.rbind.io/post/network-visualisation-in-r-package-comparison/






