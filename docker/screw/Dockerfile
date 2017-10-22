
FROM quay.io/epigenomic_screw/base

USER root
RUN apt-get -y -m update && apt-get install -y zlib1g-dev lib32z1-dev
USER ubuntu

USER ubuntu
WORKDIR /home/ubuntu
ENV HOME /home/ubuntu

RUN git clone https://github.com/Epigenomics-Screw/Screw.git
RUN mkdir /home/ubuntu/bin
RUN wget -q https://raw.githubusercontent.com/JinfengChen/Scripts/master/Shell/bedGraph2bigwig.sh -O /home/ubuntu/bin/bedGraph2bigwig.sh
RUN chmod +x /home/ubuntu/bin/bedGraph2bigwig.sh

ENV PATH $PATH:/home/ubuntu/Screw/bin:/home/ubuntu/bin

RUN conda install r-pheatmap r-optparse r-data.table r-getopt
RUN conda install bioconductor-genomeinfodb bioconductor-rtracklayer
RUN conda clean -a

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
# RUN Rscript -e "install.packages('yhatr')"
# RUN Rscript -e "install.packages('ggplot2')"
# RUN Rscript -e "install.packages('plyr')"
# RUN Rscript -e "install.packages('reshape2')"
# RUN Rscript -e "install.packages('forecast')"
# RUN Rscript -e "install.packages('stringr')"
# RUN Rscript -e "install.packages('lubridate')"
# RUN Rscript -e "install.packages('randomForest')"
# RUN Rscript -e "install.packages('rpart')"
# RUN Rscript -e "install.packages('e1071')"
# RUN Rscript -e "install.packages('kknn')"

RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('LOLA'); biocLite('rGREAT')"

# Methpipe
RUN wget -q http://smithlabresearch.org/downloads/methpipe-3.4.3.tar.bz2 -O methpipe.tar.bz2
RUN tar xvjf methpipe.tar.bz2
WORKDIR /home/ubuntu/methpipe-3.4.3
RUN export CPATH=/usr/include/gsl
RUN export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/
RUN make all && make install
RUN cp bin/* /home/ubuntu/bin/
RUN mkdir -p /home/ubuntu/bin
RUN chown -R ubuntu:ubuntu /home/ubuntu
RUN mv bin/* /home/ubuntu/bin/
RUN export PATH=$PATH:/home/ubuntu/bin
